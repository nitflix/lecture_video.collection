#!/bin/sh
# wait-for-postgres.sh

set -e
  
host="$1"
shift

until $(curl --output /dev/null --head --fail http://queue:5002/video); do
  >&2 echo "Waiting for it.."
  sleep 10
done
  
>&2 echo "Postgres is up - executing command"
exec "$@"
