if [ -z "$DOCKER_HOST" ]; then
   echo "ERROR: no DOCKER_HOST defined"
   exit 1
fi

# set the definitions
INSTANCE=db-optimizer
NAMESPACE=uvadave

docker stop $INSTANCE
docker rm -f $INSTANCE

# environment attributes
DOCKER_ENV="-e OPTIMIZE_TIME=$OPTIMIZE_TIME -e DBHOST=$DBHOST -e DBUSER=$DBUSER -e DBPASSWD=$DBPASSWD"

docker run --name $INSTANCE \
   --restart=always \
   --log-opt tag=$INSTANCE \
   $DOCKER_ENV \
   -d $NAMESPACE/$INSTANCE
