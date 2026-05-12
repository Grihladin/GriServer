#!/bin/bash

cd "$(dirname "$0")"

echo "Restarting all Docker containers..."

for dir in */; do
    if [ -f "$dir/docker-compose.yml" ]; then
        echo "Restarting in $dir..."
        (cd "$dir" && docker compose restart)
    fi
done

echo "Done."