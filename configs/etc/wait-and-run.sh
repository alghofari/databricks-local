#!/bin/sh
echo "Waiting for Trino to start on trino:8080..."
until trino --server trino:8080 --execute "SHOW CATALOGS;" > /dev/null 2>&1; do
  echo "Trino is not ready, retrying in 5 seconds..."
  sleep 5
done

echo "Trino is up - running schema creation script."
trino --server trino:8080 --execute "$(cat /docker-entrypoint-initdb.d/create_schema.sql)"
