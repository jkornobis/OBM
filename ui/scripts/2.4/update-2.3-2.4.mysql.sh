#!/bin/bash
# 
# Runs 2.3 to 2.4 schema upgrade
#

# to ensure things defaulting to system locale don't fail

echo "MySQL update shell script"

export LC_ALL=en_US.UTF-8

source `dirname $0`/obm-sh.lib

# DB parameters
get_val user
U=$VALUE
get_val password
P=$VALUE
get_val db
DB=$VALUE

mysqldump -u $U -p$P  --default-character-set='UTF8' ${DB} > ${HOME}/migration-backup.sql 
echo "database backup stored in ${HOME}/migration-backup.sql"

echo "Running 2.3 -> 2.4 schema upgrade script..."
mysql -u $U -p$P  --default-character-set='UTF8' ${DB} <  ./update-2.3-2.4.mysql.sql >/dev/null
status=$?
test $status -eq 0 || {
    echo "error on data migration, aborting."
    exit 1
}

echo "Reloading default 2.4 preferences..."
mysql -u $U -p$P  --default-character-set='UTF8' ${DB} <  ./obmdb_prefs_values_2.4.sql >/dev/null
success=$?
test ${success} -eq 0 || {
    echo "Error reloading default 2.4 preferences."
    exit 1
}
echo "[DONE]"

exit 0

