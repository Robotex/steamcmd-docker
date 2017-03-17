#!/bin/sh

LOCKFILE="/var/lock/`basename $0`"
LOCKFD=99

# PRIVATE
_lock()             { flock -$1 $LOCKFD; }
_no_more_locking()  { _lock u; _lock xn && rm -f $LOCKFILE; }
_prepare_locking()  { eval "exec $LOCKFD>\"$LOCKFILE\""; trap _no_more_locking EXIT; }

# ON START
_prepare_locking

# PUBLIC
exlock_now()        { _lock xn; }  # obtain an exclusive lock immediately or fail
exlock()            { _lock x; }   # obtain an exclusive lock
shlock()            { _lock s; }   # obtain a shared lock
unlock()            { _lock u; }   # drop a lock

### BEGIN OF SCRIPT ###

# Simplest example is avoiding running multiple instances of script.
# exlock_now || exit 1

# Remember! Lock file is removed when one of the scripts exits and it is
#           the only script holding the lock or lock is not acquired at all.

if [ ! -f /srv/srcds/serverfiles/srcds_run ]
then
    exlock_now
    if [ $? -eq 0 ]
    then
        while [ "${exitcode}" != "0" ]
        do
            /usr/games/steamcmd +runscript /srv/srcds/update.txt
            exitcode=$?
        done
    else
        exlock
    fi
    unlock
fi

. /srv/srcds/start.sh
