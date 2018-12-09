#!/usr/bin/env bash
set -e
wait_local_postgres

if [[ "$CURRENT_REPLICATION_PRIMARY_HOST" == "" ]]; then
    master_register
else
    standby_reregister
fi

echo ">>> Starting repmgr daemon..."
rm -rf "$REPMGR_PID_FILE"

gosu postgres repmgrd --daemonize=false "$REPMGR_START_OPTIONS"
