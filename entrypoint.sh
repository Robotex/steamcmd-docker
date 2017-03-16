#!/bin/sh

if [ ! -d /srv/srcds/serverfiles ]
then
    /usr/games/steamcmd +runscript /srv/srcds/update.txt validate
else
    /usr/games/steamcmd +runscript /srv/srcds/update.txt
fi

. /srv/srcds/start.sh
