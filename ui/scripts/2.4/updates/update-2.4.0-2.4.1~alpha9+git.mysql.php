<?php
require(dirname(__file__)."/../lib/update_object.inc");

class HashEventExtId extends UpdateObject {
    public function main() {
        $con = $this->get_con();
        if ($this->was_wrong_2_4_1_alpha6_update_applied($con)) {
            $this->fix_wrong_2_4_1_alpha6_update($con);
        }
        else {
            $this->upgrade_to_alpha9($con);
        }
    }

    private function was_wrong_2_4_1_alpha6_update_applied($con) {
        $con->query("SELECT COUNT(*) AS count_event_ext_id_hash ".
            "FROM information_schema.columns ".
            "WHERE table_name='opush_event_mapping' AND column_name='event_ext_id_hash'");
        $con->next_record();
        return $con->f('count_event_ext_id_hash') != 0;
    }

    private function fix_wrong_2_4_1_alpha6_update($con) {
        $con->query("SELECT COUNT(*) AS count_create_triggers ".
            "FROM information_schema.triggers ".
            "WHERE trigger_name='opush_event_mapping_event_ext_id_hash_create_trigger'");
        $con->next_record();
        if ($con->f('count_create_triggers') != 0) {
            try {
                $con->query('DROP TRIGGER '.
                    'opush_event_mapping_event_ext_id_hash_create_trigger');
            }
            catch(MySQLQueryException $ex) {
                fwrite(STDERR, "Unable to remove the trigger ".
                    "opush_event_mapping_event_ext_id_hash_create_trigger, ".
                    "please login as MySQL administrator and drop by hand");
            }
        }
        $con->query("SELECT COUNT(*) AS count_update_triggers ".
            "FROM information_schema.triggers ".
            "WHERE trigger_name='opush_event_mapping_event_ext_id_hash_update_trigger'");
        $con->next_record();
        if ($con->f('count_update_triggers') != 0) {
            try {
                $con->query('DROP TRIGGER '.
                    'opush_event_mapping_event_ext_id_hash_update_trigger');
            }
            catch(MySQLQueryException $ex) {
                fwrite(STDERR, "Unable to remove the trigger ".
                    "opush_event_mapping_event_ext_id_hash_update_trigger, ".
                    "please login as MySQL administrator and drop by hand");
            }
        }
    }

    private function upgrade_to_alpha9($con) {
        $con->begin();
        try {
            $con->lock_table_for_writing('opush_event_mapping');
            $con->query('ALTER TABLE opush_event_mapping '.
                'ADD COLUMN event_ext_id_hash BINARY(20)');

            # MySQL implicitly releases locks after an ALTER TABLE
            $con->lock_table_for_writing('opush_event_mapping');
            $con->query('SELECT DISTINCT event_ext_id FROM opush_event_mapping');
            $event_ext_ids = array();
            while ($con->next_record()) {
                $event_ext_ids[]= $con->f('event_ext_id');
            }
            foreach ($event_ext_ids as $event_ext_id) {
                $event_ext_id_hash = sha1($event_ext_id, true);
                $update_query = "UPDATE opush_event_mapping ".
                    "SET event_ext_id_hash='".mysql_real_escape_string(
                        $event_ext_id_hash)."' ".
                    "WHERE event_ext_id='".mysql_escape_string($event_ext_id)."'";
                $con->query($update_query);
            }

            $con->query('ALTER TABLE opush_event_mapping '.
                'MODIFY event_ext_id_hash BINARY(20) NOT NULL');
            # MySQL implicitly releases locks after an ALTER TABLE
            $con->lock_table_for_writing('opush_event_mapping');

            $con->query('CREATE UNIQUE INDEX '.
                    'opush_event_mapping_device_id_event_ext_id_fkey '.
                'ON opush_event_mapping (device_id, event_ext_id_hash)');
            $con->unlock_tables();
            $con->commit();
        }
        catch(Exception $ex) {
            fwrite(STDERR, "An error happened during the update, a rollback ".
                "will be attempted. This will NOT rollback schema changes!");
            $con->unlock_tables();
            $con->rollback();
            throw $ex;
        }
    }
}

$update = new HashEventExtId();
$update->main();
?>
