#!/bin/bash

cd "$(dirname "$0")"

echo "Starting all Docker containers..."

for dir in */; do
    if [ -f "$dir/docker-compose.yml" ]; then
        echo "Starting in $dir..."
        (cd "$dir" && docker compose up -d)
    fi
done

echo "Done."