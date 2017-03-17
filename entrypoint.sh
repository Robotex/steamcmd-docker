#!/bin/sh

if [ ! -f /usr/games/gameserver/serverfiles/srcds_run ]
then
    LOCKDIR="/usr/games/gameserver/serverfiles"
    flock -xn $LOCKDIR -c while true; do /usr/games/steamcmd +runscript /usr/games/gameserver/update.txt done || flock -u $LOCKDIR
fi

. /usr/games/gameserver/start.sh
