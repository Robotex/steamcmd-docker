#!/bin/sh

if [ ! -f /home/gameserver/.steam/steamcmd/linux32/steamclient.so ]
then
    /usr/games/steamcmd +login anonymous +quit
fi

if [ ! -f /usr/games/gameserver/serverfiles/srcds_run ]
then
    LOCKDIR="/usr/games/gameserver/serverfiles"
    flock -xn $LOCKDIR -c 'while sleep 5; do /usr/games/steamcmd +runscript /usr/games/gameserver/install.txt && break; done' || flock -x $LOCKDIR -c ':'
fi

. /usr/games/gameserver/start.sh
