<SCRIPT language="php">
///////////////////////////////////////////////////////////////////////////////
// OBM - File  : user_index.php                                              //
//     - Desc  : User Index File                                             //
// 2000-01-13 Florent Goalabre                                               //
///////////////////////////////////////////////////////////////////////////////
// $Id //
///////////////////////////////////////////////////////////////////////////////
// Actions :
// - index (default) -- search fields  -- show the user search form
// - search          -- search fields  -- show the result set of search
// - new             --                -- show the new user form
// - detailconsult   -- $param_user    -- show the user detail
// - detailupdate    -- $param_user    -- show the user detail form
// - insert          -- form fields    -- insert the user
// - reset           -- $param_user    -- reset user preferences
// - update          -- form fields    -- update the user
// - check_delete    -- $param_user    -- check links before delete
// - delete          -- $param_user    -- delete the user
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// Session, Auth, Perms Management                                           //
///////////////////////////////////////////////////////////////////////////////
$menu="USER";
$obminclude = getenv("OBM_INCLUDE_VAR");
require("$obminclude/phplib/obmlib.inc");
include("$obminclude/global.inc");
page_open(array("sess" => "OBM_Session", "auth" => "OBM_Challenge_Auth", "perm" => "OBM_Perm"));

// the user MUST be "admin" to access this section
$perm->check("admin");


include("$obminclude/global_pref.inc");
require("user_display.inc");
require("user_query.inc");

//There is no page_close()
$obm_user = get_param_user();  // $user is used by phplib

///////////////////////////////////////////////////////////////////////////////
// Beginning of HTML Page                                                    //
///////////////////////////////////////////////////////////////////////////////
display_head($l_user);        // Head & Body
generate_menu($menu);         // Menu
display_bookmarks();

if ($action == "index") {
///////////////////////////////////////////////////////////////////////////////
  html_user_search_form($obm_user);
  if ($set_display == "yes") {
    dis_user_search_list($obm_user);
  } else {
    display_ok_msg($l_no_display);
  }

} elseif ($action == "search")  {
///////////////////////////////////////////////////////////////////////////////
  html_user_search_form($obm_user);
  dis_user_search_list($obm_user);

} elseif ($action == "new")  {
///////////////////////////////////////////////////////////////////////////////
  include("user_js.inc");
  html_user_form(1,"",$obm_user,run_query_mycontacts());

} elseif ($action == "detailconsult")  {
///////////////////////////////////////////////////////////////////////////////
  $obm_q = run_query_detail($param_user);
  if ($obm_q->num_rows() == 1) {
    display_record_info($obm_q->f("userobm_usercreate"),$obm_q->f("userobm_userupdate"),$obm_q->f("timecreate"),$obm_q->f("timeupdate")); 
    // We get the contact infos associated to the user separatedly because it
    // would require a left join which Postgres only support from 7.1.x
    // We will left join in future version to avoid this second query
    if ($obm_q->f("userobm_contact_id")>0) {
      $obm_q_con=run_query_contact_name($obm_q->f("userobm_contact_id"));
    }
    html_user_consult($obm_q, $obm_q_con);
  } else {
    display_err_msg($l_query_error . " - " . $query . " !");
  }

} elseif ($action == "detailupdate")  {
///////////////////////////////////////////////////////////////////////////////
  $obm_q = run_query_detail($param_user);
  if ($obm_q->num_rows() == 1) {
    include("user_js.inc");
    display_record_info($obm_q->f("userobm_usercreate"),$obm_q->f("userobm_userupdate"),$obm_q->f("timecreate"),$obm_q->f("timeupdate")); 
    html_user_form(1, $obm_q, $obm_user, run_query_mycontacts());
  } else {
    display_err_msg($l_query_error . " - " . $query . " !");
  }

} elseif ($action == "insert")  {
///////////////////////////////////////////////////////////////////////////////
  if (check_data_form("", $obm_user)) {

    // If the context (same user) was confirmed ok, we proceed
    if ($hd_confirm == $c_yes) {
      $retour = run_query_insert($obm_user);
      if ($retour) {
        display_ok_msg($l_insert_ok);
        // insertion of his default preferences : 
        $user_id = run_query_id_user($obm_user["name"], $obm_user["passwd"]);
        run_query_default_preferences_insert($user_id);
      } else {
      display_err_msg($l_insert_error);
      }
      html_user_search_form($obm_user);

    // If it is the first try, we warn the user if some user seem similar
    } else {
      $obm_q = check_user_context("", $obm_user);
      if ($obm_q->num_rows() > 0) {
        dis_user_warn_insert("", $obm_q, $obm_user);
      } else {
        $retour = run_query_insert($obm_user);
        if ($retour) {
          // insertion of his default preferences : 
          $user_id = run_query_id_user($obm_user["name"], $obm_user["passwd"]);
          run_query_default_preferences_insert($user_id);
          display_ok_msg($l_insert_ok);
        } else {
          display_err_msg($l_insert_error);
        }
        html_user_search_form($obm_user);
      }
    }

  // Form data are not valid
  } else {
    display_warn_msg($l_invalid_data . " : " . $err_msg);
    html_user_form(0, "", $obm_user, run_query_mycontacts());
  }

} elseif ($action == "reset")  {
///////////////////////////////////////////////////////////////////////////////
  run_query_default_preferences_insert($param_user);
  session_load_preferences();
  display_ok_msg($l_reset_ok);
  $obm_q = run_query_detail($param_user);
  if ($obm_q->num_rows() == 1) {
    display_record_info($obm_q->f("userobm_usercreate"),$obm_q->f("userobm_userupdate"),$obm_q->f("timecreate"),$obm_q->f("timeupdate")); 
    if ($obm_q->f("userobm_contact_id")>0) {
      $obm_q_con=run_query_contact_name($obm_q->f("userobm_contact_id"));
    }
    html_user_consult($obm_q, $obm_q_con);
  } else {
    display_err_msg($l_query_error . " - " . $query . " !");
  }

} elseif ($action == "update")  {
///////////////////////////////////////////////////////////////////////////////
  if (check_data_form($param_user, $obm_user)) {
    $retour = run_query_update($param_user, $obm_user);
    if ($retour) {
      display_ok_msg($l_update_ok);
    } else {
      display_err_msg($l_update_error);
    }
    html_user_search_form($obm_user);
  } else {
    display_err_msg($err_msg);
  }

} elseif ($action == "check_delete")  {
///////////////////////////////////////////////////////////////////////////////
  require("user_js.inc");
  dis_check_links($param_user);

} elseif ($action == "delete")  {
///////////////////////////////////////////////////////////////////////////////
  $retour = run_query_delete($param_user);
  if ($retour) {
    display_ok_msg($l_delete_ok);
  } else {
    display_err_msg($l_delete_error);
  }
  run_query_delete_profil($param_user);
  html_user_search_form($obm_user);

} elseif ($action == "admin")  {
///////////////////////////////////////////////////////////////////////////////
  echo "<CENTER><FONT color=\"#$col_error\">";
  echo "To come...";
  echo "</FONT></CENTER><BR>";
}

///////////////////////////////////////////////////////////////////////////////
// Display end of page                                                       //
///////////////////////////////////////////////////////////////////////////////
page_close();
display_end();



///////////////////////////////////////////////////////////////////////////////
// Stores User parameters transmited in $obm_user hash
// returns : $obm_user hash with parameters set
///////////////////////////////////////////////////////////////////////////////
function get_param_user() {
  global $cdg_param;
  global $param_user, $tf_name, $tf_passwd, $sel_perms, $tf_email,$sel_contact;

  if (isset ($param_user)) $obm_user["id"] = $param_user;
  if (isset ($tf_name)) $obm_user["name"] = $tf_name;
  if (isset ($tf_passwd)) $obm_user["passwd"] = $tf_passwd;
  if (isset ($sel_perms)) $obm_user["perms"] = $sel_perms;
  if (isset ($tf_email)) $obm_user["email"] = $tf_email;
  if (isset ($sel_contact)) $obm_user["contact"] = $sel_contact;

  if (debug_level_isset($cdg_param)) {
    if ( $obm_user ) {
      while ( list( $key, $val ) = each( $obm_user ) ) {
        echo "<BR>user[$key]=$val";
      }
    }
  }

  return $obm_user;
}


</SCRIPT>
