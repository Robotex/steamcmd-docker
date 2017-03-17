#!/bin/sh

if [ ! -f /srv/srcds/serverfiles/srcds_run ]
then
    LOCKDIR="/srv/srcds/serverfiles"
    flock -xn $LOCKDIR
    if [ $? -eq 0 ]
    then
        echo "Master update..."
        while [ "${exitcode}" != "0" ]
        do
            /usr/games/steamcmd +runscript /srv/srcds/update.txt
            exitcode=$?
        done
    else
        echo "Slave waiting..."
        flock -x $LOCKDIR
    fi
    flock -u 
fi

. /srv/srcds/start.sh
