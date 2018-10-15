echo ">>> Making docker-compose"

FILE_FROM='./src/includes/docker-compose/docker-compose.yml'
for POSTGRES_VERSION in 10; do
    for POSTGRES_EXTENDED in ''; do
        for REPMGR_VERSION in 40; do
            for PGPOOL_VERSION in 37; do
                for BARMAN_VERSION in 24; do
                    # For postgres 9.5 we can use client 9.6
                    if [[ "$POSTGRES_VERSION" = "95" ]];then
                        PGPOOL_POSTGRES_CLIENT_VERSION="96"
                        BARMAN_POSTGRES_CLIENT_VERSION="96"
                    else
                        PGPOOL_POSTGRES_CLIENT_VERSION="$POSTGRES_VERSION"
                        BARMAN_POSTGRES_CLIENT_VERSION="$POSTGRES_VERSION"
                    fi
                    FILE_EXTENDED_SUFFIX=""
                    if [[ "$POSTGRES_EXTENDED" == "1" ]];then
                        FILE_EXTENDED_SUFFIX="-extended"
                    fi
                    VALS="POSTGRES_EXTENDED=$POSTGRES_EXTENDED FILE_EXTENDED_SUFFIX=$FILE_EXTENDED_SUFFIX POSTGRES_VERSION=$POSTGRES_VERSION PGPOOL_VERSION=$PGPOOL_VERSION BARMAN_VERSION=$BARMAN_VERSION REPMGR_VERSION=$REPMGR_VERSION PGPOOL_POSTGRES_CLIENT_VERSION=$PGPOOL_POSTGRES_CLIENT_VERSION BARMAN_POSTGRES_CLIENT_VERSION=$BARMAN_POSTGRES_CLIENT_VERSION"
                    
                    FILE_TO="./docker-compose/postgres${FILE_EXTENDED_SUFFIX}-${POSTGRES_VERSION}_repmgr-${REPMGR_VERSION}_pgpool-${PGPOOL_VERSION}_barman-${BARMAN_VERSION}.yml"
                    template $FILE_FROM $FILE_TO $VALS
                done
            done
        done
    done
done
