#!/bin/bash

# Utility Function
prompt() {
    echo -e "\033[1;34m$1\033[0m"
    read -rp "$2" $3
}

# Update and Upgrade System
sudo apt update -y && sudo apt upgrade -y

# Prompt for Database Selection
PS3="Pilih database yang ingin diinstall: "
options=("MySQL" "MariaDB" "MongoDB")
select opt in "${options[@]}"; do
    case $opt in
        "MySQL")
            DB_TYPE="mysql"
            break
            ;;
        "MariaDB")
            DB_TYPE="mariadb"
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

# Prompt for Username and Password (MySQL/MariaDB only)
if [[ "$DB_TYPE" == "mysql" || "$DB_TYPE" == "mariadb" ]]; then
    prompt "Set username untuk database Anda:" "Masukkan username: " DB_USERNAME
    prompt "Set password untuk username ($DB_USERNAME):" "Masukkan password: " DB_PASSWORD

    PS3="Pilih aksesibilitas database Anda: "
    access_options=("Publik" "Privat")
    select access_opt in "${access_options[@]}"; do
        case $access_opt in
            "Publik")
                DB_ACCESS="%"
                break
                ;;
            "Privat")
                DB_ACCESS="localhost"
                break
                ;;
        esac
    done

    CREATE_DB_OPTION=""
    prompt "Apakah Anda ingin membuat database awal? (y/n)" "Masukkan pilihan Anda: " CREATE_DB_OPTION
fi

# Install the Database
case $DB_TYPE in
    "mysql")
        sudo apt install mysql-server -y
        sudo systemctl start mysql
        sudo systemctl enable mysql

        # Update bind-address
        sudo sed -i "s/^bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf
        sudo mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'root'; FLUSH PRIVILEGES;"
        sudo systemctl restart mysql
        ;;
    "mariadb")
        sudo apt install mariadb-server -y
        sudo systemctl start mariadb
        sudo systemctl enable mariadb

        # Update bind-address
        sudo sed -i "s/^bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/mariadb.conf.d/50-server.cnf
        sudo systemctl restart mariadb
        ;;
    "mongodb")
        sudo apt install -y mongodb
        sudo systemctl start mongodb
        sudo systemctl enable mongodb
        ;;
esac

# Configure Database (MySQL/MariaDB)
if [[ "$DB_TYPE" == "mysql" || "$DB_TYPE" == "mariadb" ]]; then
    sudo mysql -e "DROP USER IF EXISTS '$DB_USERNAME'@'$DB_ACCESS';"
    sudo mysql -e "CREATE USER '$DB_USERNAME'@'$DB_ACCESS' IDENTIFIED BY '$DB_PASSWORD';"
    sudo mysql -e "GRANT ALL PRIVILEGES ON *.* TO '$DB_USERNAME'@'$DB_ACCESS' WITH GRANT OPTION;"
    sudo mysql -e "FLUSH PRIVILEGES;"

    if [[ "$CREATE_DB_OPTION" == "y" || "$CREATE_DB_OPTION" == "Y" ]]; then
        DB_NAME=""
        prompt "Masukkan nama database awal yang ingin dibuat:" "Nama database: " DB_NAME
        sudo mysql -e "CREATE DATABASE $DB_NAME;"
        echo "Database $DB_NAME telah berhasil dibuat."
    fi

    # Install and Open Firewall for MySQL/MariaDB
    sudo apt install ufw -y
    sudo ufw allow 3306
    sudo systemctl restart mysql
fi

# Output Instructions to Access Database
cat <<EOL

=======================================
Database telah berhasil diinstall dan dikonfigurasi.

Petunjuk untuk mengakses database:
- Gunakan MySQL/MariaDB Client:
  mysql -u $DB_USERNAME -p -h [IP_SERVER]
  Masukkan password saat diminta.
- Gunakan GUI Client seperti DBeaver, HeidiSQL, atau phpMyAdmin untuk akses grafis.

Jika Anda menginstall MongoDB:
- Gunakan Mongo Shell:
  mongo --host [IP_SERVER]

=======================================
EOL

