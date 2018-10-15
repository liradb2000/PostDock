#!/usr/bin/env bash
slave12=1 pgpool=1 backup=1 make/make.sh docker-compose && docker rm -f $(docker ps -a --filter name=dockercompose -q) ; docker volume rm $(docker volume ls --filter name=dockercompose -q) ; docker-compose -f docker-compose/postgres-10_repmgr-40_pgpool-37_barman-24.yml up
