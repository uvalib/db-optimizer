if [ -z "$DOCKER_HOST" ]; then
   echo "ERROR: no DOCKER_HOST defined"
   exit 1
fi

# set the definitions
INSTANCE=db-optimizer
NAMESPACE=uvadave

# environment attributes
DOCKER_ENV="-e OPTIMIZE_TIME=$OPTIMIZE_TIME -e DBHOST=$DBHOST -e DBUSER=$DBUSER -e DBPASSWD=$DBPASSWD"

docker run -t -i $DOCKER_ENV $NAMESPACE/$INSTANCE /bin/bash -l
