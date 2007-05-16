{include file="header.tpl"}

<h1>
  {if $entry.type != ''}
  <img src="pix/{$entry.type}.png" border="0" width="22" height="22" align="middle" title="{$entry.type}">
  {/if}
  {$entry.givenname} {$entry.name}
</h1>

<form action="entry.php" method="post" enctype="multipart/form-data" accept-charset="utf-8">
<input type="hidden" name="MAX_FILE_SIZE" value="2000000" />
<input type="hidden" name="dn" value="{$entry.dn|escape}" />
<input type="hidden" name="save" value="1" />

<table width="100%">
<!--  -->
  <tr>
    <td valign="top" width="50%" align="center">
      <table>
{* always required ... if $fields.name *}
        <tr>
          <td align="right" valign="top" nowrap="nowrap">{$lang.name}:</td>
          <td><input type="text" class="input" name="entry[name]" value="{$entry.name|escape}" id="firstfield"></td>
        </tr>
{* /if *}
{if $fields.givenname}
        <tr>
          <td align="right" valign="top" nowrap="nowrap">{$lang.givenname}:</td>
          <td><input type="text" class="input" name="entry[givenname]" value="{$entry.givenname|escape}"></td>
        </tr>
{/if}
{if $fields.title}
        <tr>
          <td align="right" valign="top" nowrap="nowrap">{$lang.title}:</td>
          <td><input type="text" class="input" name="entry[title]" value="{$entry.title|escape}"></td>
        </tr>
{/if}
      </table>
    </td>

    <td valign="top" width="50%" align="center">
    </td>
  </tr>

  <tr>
    <td colspan="2"><hr /></td>
  </tr>

  <tr>
    <td valign="top" width="50%" align="center">
      <table>
        <tr>
          <td colspan="2"><b>{$lang.business}</b></td>
        </tr>
{if $fields.organization}
        <tr>
          <td align="right" valign="top" nowrap="nowrap">{$lang.organization}:</td>
          <td>
            <input type="text" class="input" name="entry[organization]" value="{$entry.organization|escape}">
          </td>
        </tr>
{/if}
{if $fields.office}
        <tr>
          <td align="right" valign="top" nowrap="nowrap">{$lang.office}:</td>
          <td><input type="text" class="input" name="entry[office]" value="{$entry.office|escape}"></td>
        </tr>
{/if}
{if $fields.street}
        <tr>
          <td align="right" valign="top" nowrap="nowrap">{$lang.street}:</td>
          <td><input type="text" class="input" name="entry[street]" value="{$entry.street|escape}"></td>
        </tr>
{/if}
{if $fields.zip}
        <tr>
          <td align="right" valign="top" nowrap="nowrap">{$lang.zip}:</td>
          <td><input type="text" class="input" name="entry[zip]" value="{$entry.zip|escape}"></td>
        </tr>
{/if}
{if $fields.location}
        <tr>
          <td align="right" valign="top" nowrap="nowrap">{$lang.location}:</td>
          <td><input type="text" class="input" name="entry[location]" value="{$entry.location|escape}"></td>
        </tr>
{/if}
{if $fields.state}
        <tr>
          <td align="right" valign="top" nowrap="nowrap">{$lang.state}:</td>
          <td><input type="text" class="input" name="entry[state]" value="{$entry.state|escape}"></td>
        </tr>
{/if}
{if $fields.country}
        <tr>
          <td align="right" valign="top">{$lang.country}:</td>
          <td>
            <input type="text" class="inputbr" name="entry[country]" value="{$entry.country|escape}"><br>
          </td>
        </tr>
{/if}
{if $fields.phone}
        <tr>
          <td align="right" valign="top" nowrap="nowrap">{$lang.phone}:</td>
          <td><input type="text" class="input" name="entry[phone]" value="{$entry.phone|escape}"></td>
        </tr>
{/if}
{if $fields.switchboard}
        <tr>
          <td align="right" valign="top" nowrap="nowrap">{$lang.switchboard}:</td>
          <td><input type="text" class="input" name="entry[switchboard]" value="{$entry.switchboard|escape}"></td>
        </tr>
{/if}
{if $fields.fax}
        <tr>
          <td align="right" valign="top" nowrap="nowrap">{$lang.fax}:</td>
          <td><input type="text" class="input" name="entry[fax]" value="{$entry.fax|escape}"></td>
        </tr>
{/if}
{if $fields.pager}
        <tr>
          <td align="right" valign="top" nowrap="nowrap">{$lang.pager}:</td>
          <td><input type="text" class="input" name="entry[pager]" value="{$entry.pager|escape}"></td>
        </tr>
{/if}
{if $fields.manager}
        <tr>
          <td align="right" valign="top" nowrap="nowrap">{$lang.manager}:</td>
          <td>
            <select name="entry[manager]" class="input">
              <option value="">--- {$lang.select} ---</option>
              {html_options options=$managers selected=$entry.manager}
            </select>
          </td>
        </tr>
{/if}
{if $fields.position}
        <tr>
          <td align="right" valign="top">{$lang.position}:</td>
          <td><input type="text" class="input" name="entry[position]" value="{$entry.position|escape}"></td>
        </tr>
{/if}
{if $fields.department}
        <tr>
          <td align="right" valign="top">{$lang.department}:</td>
          <td><input type="text" class="input" name="entry[department]" value="{$entry.department|escape}"></td>
        </tr>
{/if}

      </table>
    </td>

    <td valign="top" width="50%" align="center">

      <table>
        <tr>
          <td colspan="2"><b>{$lang.private}</b></td>
        </tr>
{if $fields.homestreet}
        <tr>
          <td align="right" valign="top" nowrap="nowrap">{$lang.homestreet}:</td>
          <td><textarea name="entry[homestreet]" class="input" rows="2" cols="30">{$entry.homestreet|escape}</textarea></td>
        </tr>
{/if}
{if $fields.homephone}
        <tr>
          <td align="right" valign="top" nowrap="nowrap">{$lang.homephone}:</td>
          <td><input type="text" class="input" name="entry[homephone]" value="{$entry.homephone|escape}"></td>
        </tr>
{/if}
{if $fields.mobile}
        <tr>
          <td align="right" valign="top" nowrap="nowrap">{$lang.mobile}:</td>
          <td><input type="text" class="input" name="entry[mobile]" value="{$entry.mobile|escape}"></td>
        </tr>
{/if}
{if $fields.url}
        <tr>
          <td align="right" valign="top" nowrap="nowrap">{$lang.url}:</td>
          <td><input type="text" class="input" name="entry[url]" value="{$entry.url|escape}"></td>
        </tr>
{/if}
{if $fields.photo}
        <tr>
          <td align="right" valign="top" nowrap="nowrap">{$lang.photo}:<br /><span class="hint">({$lang.msg_jpegonly})</span></td>
          <td>{if $entry.photo}
                <input type="checkbox" class="radio" name="delphoto" id="delphoto" value="1">
                <label for="delphoto">{$lang.delphoto}</label>
                <br />
              {/if}
            <input type="file" class="input" name="photoupload">
          </td>
        </tr>
{/if}
{if $fields.birthday}
        <tr>
          <td align="right" valign="top">{$lang.birthday}:<br><span class="hint">({$lang.msg_dateformat})</span></td>
          <td><input type="text" class="input" name="entry[birthday]" value="{$entry.birthday|escape}" maxlength="10"></td>
        </tr>
{/if}
{if $fields.anniversary}
        <tr>
          <td align="right" valign="top" nowrap="nowrap">{$lang.anniversary}:<br><span class="hint">({$lang.msg_dateformat})</span></td>
          <td><input type="text" class="input" name="entry[anniversary]" value="{$entry.anniversary|escape}" maxlength="10"></td>
        </tr>
{/if}
{if $fields.spouse}
        <tr>
          <td align="right" valign="top" nowrap="nowrap">{$lang.spouse}:</td>
          <td><input type="text" class="input" name="entry[spouse]" value="{$entry.spouse|escape}"></td>
        </tr>
{/if}

        <tr>
          <td colspan="2"><b>{$lang.communication}</b></td>
        </tr>
{if $fields._mail}
        {foreach from=$entry.mail item=mail}
        <tr>
          <td align="right" valign="top" nowrap="nowrap">{$lang.mail} {counter}:</td>
          <td><input type="text" class="input" name="entry[mail][]" value="{$mail|escape}"></td>
        </tr>
        {/foreach}
        <tr>
          <td align="right" valign="top" nowrap="nowrap">{$lang.mail} {counter}:</td>
          <td><input type="text" class="input" name="entry[mail][]" value=""></td>
        </tr>
        <tr>
          <td align="right" valign="top" nowrap="nowrap">{$lang.mail} {counter}:</td>
          <td><input type="text" class="input" name="entry[mail][]" value=""></td>
        </tr>
{/if}
{if $fields.instantmessenger}
        <tr>
          <td align="right" valign="top">{$lang.instantmessenger}:</td>
          <td><input type="text" class="input" name="entry[instantmessenger]" value="{$entry.instantmessenger|escape}"></td>
        </tr>
{/if}
{if $fields.ipphone}
        <tr>
          <td align="right" valign="top">{$lang.ipphone}:</td>
          <td><input type="text" class="input" name="entry[ipphone]" value="{$entry.ipphone|escape}"></td>
        </tr>
{/if}

      </table>
    </td>
  </tr>

  <tr>
    <td colspan="2"><hr /></td>
  </tr>

  <tr>
    <td width="50%" valign="top" align="center">
      <table>
        <tr>
          <td colspan="2"><b>{$lang.extended}</b></td>
        </tr>
{if $fields._marker}
        <tr>
          <td align="right" valign="top" nowrap="nowrap">{$lang.marker}:<br><span class="hint">({$lang.msg_tagsep})</span></td>
          <td>
            <textarea class="input" name="entry[markers]" id="tageditlookup">{$entry.markers|escape}</textarea><div id="tageditresult" class="autocomplete"></div>
          </td>
        </tr>
{/if}
{if $fields.note}
        <tr>
          <td align="right" valign="top">{$lang.note}:</td>
          <td align="right"><textarea class="input" rows="6" cols="30" name="entry[note]" class="note">{$entry.note|escape}</textarea></td>
        </tr>
{/if}

      </table>
    </td>
    <td width="50%" valign="top" align="center">
      <table>
{if $fields.certificate}
        <tr>
          <td align="right" valign="top">{$lang.certificate}:</td>
          <td>
            <textarea name="entry[certificate]" class="input" rows="6" cols="28" onClick="this.form.elements['entry[certificate]'].select();">{$entry.certificate|escape}</textarea>
            <br><input type="button" name="clearCert" value="Clear" onClick="if (confirm('Are you sure?')) this.form.elements['entry[certificate]'].value='';">
          </td>
        </tr>
{/if}
{if $fields.domain}
        <tr>
          <td align="right" valign="top">{$lang.domain}:</td>
          <td><input type="text" class="input" name="entry[domain]" value="{$entry.domain|escape}"></td>
        </tr>
{/if}
{if $fields.timezone}
        <tr>
          <td align="right" valign="top">{$lang.timezone}:</td>
          <td>
            <input type="text" class="inputbr" name="entry[timezone]" value="{$entry.timezone|escape}"><br>
          </td>
        </tr>
{/if}
      </table>
    </td>
  </tr>

  {if $entry.dn == ''}
  <tr>
    <td colspan="2" align="center">
      {$lang.msg_addto}<br>
      <table><tr><td>
      <input type="radio" name="type" value="public" id="typepublic" class="radio" checked="checked">
      <label for="typepublic"><img src="pix/public.png" border="0" width="16" height="16" align="middle">{$lang.publicbook}</label><br>
      <input type="radio" name="type" value="private" id="typeprivate" class="radio">
      <label for="typeprivate"><img src="pix/private.png" border="0" width="16" height="16" align="middle">{$lang.privatebook}</label>
      </td></tr></table>
    </td>
  </tr>
  {/if}

  <tr>
    <td colspan="2" align="center"><br><input type="submit" class="input" value="{$lang.submit}"></td>
  </tr>
</table>

</form>

{include file="footer.tpl"}
