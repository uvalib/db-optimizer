FROM alpine:3.11

# Add necessary packages
RUN apk --update add bash tzdata mariadb-client postgresql-client ca-certificates

# Create the run user and group
RUN addgroup --gid 18570 sse && adduser --uid 1984 docker -G sse -D

# set the timezone appropriatly
ENV TZ=UTC
RUN cp /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Specify home 
ENV APP_HOME /db-optimizer
WORKDIR $APP_HOME

# install the app
COPY . $APP_HOME

# Update permissions
RUN chown -R docker $APP_HOME && chgrp -R sse $APP_HOME

# Specify the user
USER docker

# define startup script
CMD scripts/entry.ksh

# move in the profile
COPY data/container_bash_profile /home/docker/.profile
