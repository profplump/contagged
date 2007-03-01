<?
  require_once('init.php');
  ldap_login();

  //prepare filter
  $ldapfilter = _makeldapfilter();

  //check public addressbook
  $sr = ldap_list($LDAP_CON,$conf['publicbook'],$ldapfilter);
  $result1 = ldap_get_binentries($LDAP_CON, $sr);
  //check users private addressbook
  if(!empty($_SESSION['ldapab']['binddn'])){
    $sr = @ldap_list($LDAP_CON,
                    $conf['privatebook'].','.$_SESSION['ldapab']['binddn'],
                    $ldapfilter);
    $result2 = ldap_get_binentries($LDAP_CON, $sr);
  }else{
    $result2 = '';
  }

  $result = array_merge((array)$result1,(array)$result2);

  // select entry template
  if(!empty($_REQUEST['export']) && $_REQUEST['export'] == 'csv'){
    $entrytpl = 'export_list_csv_entry.tpl';
  }else{
    $entrytpl = 'list_entry.tpl';
  }

  $list = '';
  if(count($result)==1 && $_REQUEST['search']){
    //only one result on a search -> display page
    header("Location: entry.php?dn=".$result[0]['dn']);
    exit;
  }elseif(count($result)){
    $keys = array_keys($result);
    uksort($keys,"_namesort");
    foreach($keys as $key){
      tpl_entry($result[$key]);
      $list .= $smarty->fetch($entrytpl);
    }
  }

  //prepare templates
  tpl_std();
  tpl_markers(); //FIXME not needed anymore!?
  tpl_categories();
  tpl_timezone();
  tpl_country();
  if (empty($_REQUEST['filter'])) $_REQUEST['filter']='';
  if (empty($_REQUEST['marker'])) $_REQUEST['marker']='';
  if (empty($_REQUEST['search'])) $_REQUEST['search']='';
  $smarty->assign('list',$list);
  $smarty->assign('filter',$_REQUEST['filter']);
  $smarty->assign('marker',$_REQUEST['marker']);
  $smarty->assign('search',$_REQUEST['search']);
  //display templates
  if(!empty($_REQUEST['export']) && $_REQUEST['export'] == 'csv'){
    if ($conf['userlogreq'] == 1 && $user == '')
    {
      header("HTTP/1.1 401 ACCESS DENIED");
      exit();
    } else {
      header("Content-Type: text/csv");
      header('Content-Disposition: Attachement; filename="contagged_export.csv"');
      $smarty->display('export_list_csv.tpl');
    }
  }else{
    //save location in session
    $_SESSION['ldapab']['lastlocation']=$_SERVER["REQUEST_URI"];

    header('Content-Type: text/html; charset=utf-8');
    $smarty->display('list.tpl');
  }

  //------- functions -----------//

  /**
   * callback function to sort entries by name
   * uses global $result
   */
  function _namesort($a,$b){
    global $result;
    global $FIELDS;
    if (empty($result[$a][$FIELDS['givenname']])) { $result[$a][$FIELDS['givenname']]=''; }
    if (empty($result[$b][$FIELDS['givenname']])) { $result[$b][$FIELDS['givenname']]=''; }
    $x = $result[$a][$FIELDS['name']][0].$result[$a][$FIELDS['givenname']][0];
    $y = $result[$b][$FIELDS['name']][0].$result[$b][$FIELDS['givenname']][0];
    return(strcasecmp($x,$y));
  }


  /**
   * Creates an LDAP filter from given request variables search or filter
   */
  function _makeldapfilter(){
    global $FIELDS;

    //handle given filter

    if (empty($_REQUEST['filter'])) { $_REQUEST['filter']=''; }
    if (empty($_REQUEST['search'])) { $_REQUEST['search']=''; }
    if (empty($_REQUEST['org'])) { $_REQUEST['org']=''; }
    if (empty($_REQUEST['marker'])) { $_REQUEST['marker']=''; }
    $filter = ldap_filterescape($_REQUEST['filter']);
    $search = ldap_filterescape($_REQUEST['search']);
    $org    = ldap_filterescape($_REQUEST['org']);
    $marker = ldap_filterescape($_REQUEST['marker']);
    $_SESSION['ldapab']['filter'] = $_REQUEST['filter'];
    if(empty($filter)) $filter='a';

    if(!empty($marker)){
      // Search by tag
      $ldapfilter = '(&(objectClass=contactPerson)';
      $marker = explode(',',$marker);
      foreach($marker as $m){
        $m = trim($m);
        $ldapfilter .= '('.$FIELDS['*marker'].'='.$m.')';
      }
      $ldapfilter .= ')';
    }elseif(!empty($search)){
      // Search name and organization
      $search = trim($search);
      $words=preg_split('/\s+/',$search);
      $filter='';
      foreach($words as $word){
        $filter .= '(|(|('.$FIELDS['name'].'=*'.$word.'*)('.
                   $FIELDS['givenname'].'=*'.$word.'*))('.
                   $FIELDS['organization'].'=*'.$word.'*))';
      }
      $ldapfilter = "(&(objectClass=inetOrgPerson)$filter)";
    }elseif(!empty($org)){
      // List organization members
      $ldapfilter = '(&(objectClass=inetOrgPerson)('.$FIELDS['organization']."=$org))";
    }elseif($filter=='other'){
      // Alphabetic listing of last names
      $other='';
      for ($i=ord('a');$i<=ord('z');$i++){
        $other .= '(!('.$FIELDS['name'].'='.chr($i).'*))';
      }
      $ldapfilter = "(&(objectClass=inetOrgPerson)$other)";
    }elseif($filter=='*'){
      // List all
      $ldapfilter = "(objectClass=inetOrgPerson)";
    }else{
      // Search by last name start
      $ldapfilter = '(&(objectClass=inetOrgPerson)('.$FIELDS['name']."=$filter*))";
    }
    return $ldapfilter;
  }
?>
