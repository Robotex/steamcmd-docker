#!/bin/sh

if [ ! -f /usr/games/gameserver/serverfiles/srcds_run ]
then
    LOCKDIR="/usr/games/gameserver/serverfiles"
    flock -xn $LOCKDIR
    if [ $? -eq 0 ]
    then
        echo "Master update..."
        while [ "${exitcode}" != "0" ]
        do
            /usr/games/steamcmd +runscript /usr/games/gameserver/update.txt
            exitcode=$?
        done
    else
        echo "Slave waiting..."
        flock -x $LOCKDIR
    fi
    flock -u 
fi

. /usr/games/gameserver/start.sh
