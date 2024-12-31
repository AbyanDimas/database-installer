#!/bin/bash

# Fungsi untuk mencetak pesan
print_message() {
    echo -e "\033[1;32m$1\033[0m"
}

# Pilih tipe database
PS3="Pilih database untuk restore: "
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

# Prompt untuk informasi restore
if [[ "$DB_TYPE" == "mysql" ]]; then
    read -rp "Masukkan nama database yang ingin di-restore: " DB_NAME
    read -rp "Masukkan username database: " DB_USER
    read -rp "Masukkan password database: " DB_PASS
    read -rp "Masukkan nama file backup (.sql): " BACKUP_FILE

    mysql -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" < "$BACKUP_FILE"

    if [[ $? -eq 0 ]]; then
        print_message "Restore berhasil ke database $DB_NAME"
    else
        echo "Restore gagal."
    fi
elif [[ "$DB_TYPE" == "mongodb" ]]; then
    read -rp "Masukkan nama direktori backup: " BACKUP_DIR

    mongorestore "$BACKUP_DIR"

    if [[ $? -eq 0 ]]; then
        print_message "Restore berhasil dari $BACKUP_DIR"
    else
        echo "Restore gagal."
    fi
fi
