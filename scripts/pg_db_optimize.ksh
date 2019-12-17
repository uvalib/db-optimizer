#!/usr/bin/env bash
#
# Runner process to do the db optimize
#

# source the helper...
DIR=$(dirname $0)
. $DIR/helpers.ksh

# useful values
MYNAME=$(basename $0)

# validate the environment
if [ -z "$DBHOST" ]; then
   error_and_exit "no DBHOST; please define your database host"
fi
if [ -z "$DBUSER" ]; then
   error_and_exit "no DBUSER; please define your database user"
fi
if [ -z "$DBNAMES" ]; then
   error_and_exit "no DBNAMES; please define your database name(s)"
fi
if [ -z "$DBPASSWD" ]; then
#   error_and_exit "no DBPASSWD; please define your database password"
   export PGPASSWORD=""
else
   export PGPASSWORD=$DBPASSWD
fi

if [ -z "$OPTIMIZE_TIME" ]; then
   error_and_exit "no OPTIMIZE_TIME; please define your optimize time"
fi

# the time we want the action to occur
# this is specified in localtime
export ACTION_TIME=$OPTIMIZE_TIME
export ACTION_TIMEZONE="America/New_York"

# helpful message...
banner_message "$MYNAME: starting up..."

# forever...
while true; do

   # sleeping message...
   banner_message "$MYNAME: sleeping until $ACTION_TIME ($ACTION_TIMEZONE)..."
   sleep_until $ACTION_TIME $ACTION_TIMEZONE

   # status message
   banner_message "$MYNAME: starting DB vacumn sequence"

   # do the database optimizations
   for db in $DBNAMES; do
      vacuumdb -h $DBHOST -U $DBUSER -d $db --analyze
      res=$?
      if [ $res -ne 0 ]; then
         banner_message "ERROR: returned $res during database vacumn of $db; abandoning further processing"
         sleep 60
         continue
      fi
   done

   # ending message
   banner_message "$MYNAME: sequence completes successfully"

   # sleep for another minute
   sleep 60

done

# never get here...
exit 0

#
# end of file
#
