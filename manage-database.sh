#!/bin/bash

# Utility Function
prompt() {
    echo -e "\033[1;34m$1\033[0m"
    read -rp "$2" $3
}

# Function to List Users
list_users() {
    if [[ "$DB_TYPE" == "mysql" || "$DB_TYPE" == "mariadb" ]]; then
        sudo mysql -e "SELECT User, Host FROM mysql.user;"
    elif [[ "$DB_TYPE" == "mongodb" ]]; then
        mongo --eval "db.getUsers();"
    fi
}

# Function to Add User
add_user() {
    prompt "Masukkan username baru:" "Username: " NEW_USER
    prompt "Masukkan password untuk $NEW_USER:" "Password: " NEW_PASSWORD

    if [[ "$DB_TYPE" == "mysql" || "$DB_TYPE" == "mariadb" ]]; then
        sudo mysql -e "CREATE USER '$NEW_USER'@'%' IDENTIFIED BY '$NEW_PASSWORD';"
        echo "Pengguna $NEW_USER berhasil ditambahkan."
    elif [[ "$DB_TYPE" == "mongodb" ]]; then
        mongo --eval "db.createUser({user: '$NEW_USER', pwd: '$NEW_PASSWORD', roles: [{role: 'readWrite', db: 'admin'}]});"
        echo "Pengguna $NEW_USER berhasil ditambahkan."
    fi
}

# Function to Remove User
remove_user() {
    prompt "Masukkan username yang ingin dihapus:" "Username: " REMOVE_USER

    if [[ "$DB_TYPE" == "mysql" || "$DB_TYPE" == "mariadb" ]]; then
        sudo mysql -e "DROP USER '$REMOVE_USER'@'%';"
        echo "Pengguna $REMOVE_USER berhasil dihapus."
    elif [[ "$DB_TYPE" == "mongodb" ]]; then
        mongo --eval "db.dropUser('$REMOVE_USER');"
        echo "Pengguna $REMOVE_USER berhasil dihapus."
    fi
}

# Function to List Databases
list_databases() {
    if [[ "$DB_TYPE" == "mysql" || "$DB_TYPE" == "mariadb" ]]; then
        sudo mysql -e "SHOW DATABASES;"
    elif [[ "$DB_TYPE" == "mongodb" ]]; then
        mongo --eval "printjson(db.adminCommand({ listDatabases: 1 }));"
    fi
}

# Function to Add Database
add_database() {
    prompt "Masukkan nama database baru:" "Nama Database: " NEW_DATABASE

    if [[ "$DB_TYPE" == "mysql" || "$DB_TYPE" == "mariadb" ]]; then
        sudo mysql -e "CREATE DATABASE $NEW_DATABASE;"
        echo "Database $NEW_DATABASE berhasil dibuat."
    elif [[ "$DB_TYPE" == "mongodb" ]]; then
        mongo --eval "use $NEW_DATABASE;"
        echo "Database $NEW_DATABASE berhasil dibuat."
    fi
}

# Function to Remove Database
remove_database() {
    prompt "Masukkan nama database yang ingin dihapus:" "Nama Database: " REMOVE_DATABASE

    if [[ "$DB_TYPE" == "mysql" || "$DB_TYPE" == "mariadb" ]]; then
        sudo mysql -e "DROP DATABASE $REMOVE_DATABASE;"
        echo "Database $REMOVE_DATABASE berhasil dihapus."
    elif [[ "$DB_TYPE" == "mongodb" ]]; then
        mongo --eval "db.getSiblingDB('$REMOVE_DATABASE').dropDatabase();"
        echo "Database $REMOVE_DATABASE berhasil dihapus."
    fi
}

# Main Menu
PS3="Pilih database yang ingin dikelola: "
options=("MySQL" "MariaDB" "MongoDB" "Keluar")
select opt in "${options[@]}"; do
    case $opt in
        "MySQL"|"MariaDB")
            DB_TYPE="mysql"
            [[ "$opt" == "MariaDB" ]] && DB_TYPE="mariadb"
            ;;
        "MongoDB")
            DB_TYPE="mongodb"
            ;;
        "Keluar")
            echo "Keluar dari program."
            exit
            ;;
        *)
            echo "Pilihan tidak valid, coba lagi." ;;
    esac

    while true; do
        PS3="Pilih operasi untuk $DB_TYPE: "
        operations=("Lihat Pengguna" "Tambah Pengguna" "Hapus Pengguna" "Lihat Database" "Tambah Database" "Hapus Database" "Kembali")
        select operation in "${operations[@]}"; do
            case $operation in
                "Lihat Pengguna")
                    list_users
                    break
                    ;;
                "Tambah Pengguna")
                    add_user
                    break
                    ;;
                "Hapus Pengguna")
                    remove_user
                    break
                    ;;
                "Lihat Database")
                    list_databases
                    break
                    ;;
                "Tambah Database")
                    add_database
                    break
                    ;;
                "Hapus Database")
                    remove_database
                    break
                    ;;
                "Kembali")
                    break 2
                    ;;
                *)
                    echo "Pilihan tidak valid, coba lagi." ;;
            esac
        done
    done

done
