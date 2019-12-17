#!/usr/bin/env bash

# source the helper...
DIR=$(dirname $0)
. $DIR/helpers.ksh

# validate the environment
if [ -z "$DBMODE" ]; then
   error_and_exit "no DBMODE; please define your database mode"
fi

# define the run script name
RUNNER=scripts/${DBMODE}_db_optimize.ksh

if [ ! -f $RUNNER ]; then
   error_and_exit "no support for $DBMODE optimization"
fi

# run the optimizer script
$RUNNER

# never get here

#
# end of file
#
