#!/bin/bash

export PORT=8000
export MIX_ENV=prod
DIR=$1

if [ ! -d "$DIR" ]; then
  printf "Usage: ./deploy.sh <path>\n"
  exit
fi

echo "Deploy to [$DIR]"

mix deps.get
mix release.init
(cd assets && npm install)
(cd assets && ./node_modules/brunch/bin/brunch b -p)
mix phx.digest
mix release --env=prod

printf "stopping microblog..."

systemctl stop microblog

printf "migrating"

mix ecto.migrate

printf "unzipping tar"

SRC=`pwd`
(cd $DIR && tar xzvf $SRC/_build/prod/rel/microblog/releases/0.0.1/microblog.tar.gz)

printf "starting microblog"

systemctl start  microblog
