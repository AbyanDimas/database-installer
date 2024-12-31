#!/bin/bash

print_status() {
    echo -e "\033[1;34m$1\033[0m"
}

services=("mysql" "mariadb" "mongodb")
for service in "${services[@]}"; do
    if systemctl is-active --quiet "$service"; then
        print_status "Layanan $service sedang berjalan."
    else
        echo "Layanan $service tidak berjalan."
    fi
done
