#!/bin/sh

if [ ! -f /usr/games/gameserver/serverfiles/srcds_run ]
then
    LOCKDIR="/usr/games/gameserver/serverfiles"
    flock -xn $LOCKDIR -c 'while sleep 5; do /usr/games/steamcmd +runscript /usr/games/gameserver/update.txt; done' || flock -x $LOCKDIR -c ':'
fi

. /usr/games/gameserver/start.sh
