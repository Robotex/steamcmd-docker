#!/bin/sh

if [ ! -f /srv/srcds/serverfiles/srcds_run ]
then
    while [ "${exitcode}" != "0" ]
    do
        /usr/games/steamcmd +runscript /srv/srcds/update.txt
        exitcode=$?
    done
fi

. /srv/srcds/start.sh
