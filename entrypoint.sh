#!/bin/sh

if [ ! -f /srv/srcds/serverfiles/srcds_run ]
then
    /usr/games/steamcmd +runscript /srv/srcds/update.txt
fi

. /srv/srcds/start.sh
