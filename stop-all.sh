#!/bin/bash

cd "$(dirname "$0")"

echo "Stopping all Docker containers..."

for dir in */; do
    if [ -f "$dir/docker-compose.yml" ]; then
        echo "Stopping in $dir..."
        (cd "$dir" && docker compose stop)
    fi
done

echo "Done."