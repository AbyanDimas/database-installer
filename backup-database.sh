#!/bin/bash

# Fungsi untuk mencetak pesan
print_message() {
    echo -e "\033[1;32m$1\033[0m"
}

# Pilih tipe database
PS3="Pilih database untuk backup: "
options=("MySQL/MariaDB" "MongoDB")
select opt in "${options[@]}"; do
    case $opt in
        "MySQL/MariaDB")
            DB_TYPE="mysql"
            break
            ;;
        "MongoDB")
            DB_TYPE="mongodb"
            break
            ;;
        *)
            echo "Pilihan tidak valid, coba lagi." ;;
    esac
done

# Prompt untuk informasi backup
if [[ "$DB_TYPE" == "mysql" ]]; then
    read -rp "Masukkan nama database yang ingin di-backup: " DB_NAME
    read -rp "Masukkan username database: " DB_USER
    read -rp "Masukkan password database: " DB_PASS

    BACKUP_FILE="${DB_NAME}_backup_$(date +%F).sql"
    mysqldump -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" > "$BACKUP_FILE"

    if [[ $? -eq 0 ]]; then
        print_message "Backup berhasil disimpan di $BACKUP_FILE"
    else
        echo "Backup gagal."
    fi
elif [[ "$DB_TYPE" == "mongodb" ]]; then
    read -rp "Masukkan nama database yang ingin di-backup: " DB_NAME

    BACKUP_DIR="${DB_NAME}_backup_$(date +%F)"
    mongodump --db "$DB_NAME" --out "$BACKUP_DIR"

    if [[ $? -eq 0 ]]; then
        print_message "Backup berhasil disimpan di $BACKUP_DIR"
    else
        echo "Backup gagal."
    fi
fi
