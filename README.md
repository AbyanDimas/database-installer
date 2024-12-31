# Database Installation Script

## Description
Repository ini berisi kumpulan skrip Bash untuk mengotomatisasi instalasi, konfigurasi, backup, restore, dan pengecekan status database populer seperti MySQL, MariaDB, dan MongoDB. Skrip ini dirancang untuk mempermudah pengelolaan database dengan interaksi yang sederhana.

## Fitur Utama
1. **Instalasi Database:**
   - Pilih dan instal MySQL, MariaDB, atau MongoDB.
   - Konfigurasi aksesibilitas dan kredensial database.
   - Opsional membuat database awal untuk MySQL dan MariaDB.

2. **Backup Database:**
   - Backup MySQL/MariaDB ke file `.sql`.
   - Backup MongoDB ke direktori yang ditentukan.

3. **Restore Database:**
   - Restore MySQL/MariaDB dari file `.sql`.
   - Restore MongoDB dari direktori backup.

4. **Pengecekan Status Database:**
   - Memeriksa apakah layanan database (MySQL, MariaDB, atau MongoDB) sedang berjalan.

5. **Konfigurasi Firewall:**
   - Membuka port yang diperlukan untuk akses database.

## Prasyarat
- Sistem berbasis Linux (teruji pada Ubuntu).
- Akses `sudo` untuk menjalankan perintah instalasi.

## Penggunaan
1. Clone repository:
   ```bash
   git clone https://github.com/abyandimas/database-installer.git
   cd database-installer
   ```

2. Buat skrip dapat dieksekusi:
   ```bash
   chmod +x *.sh
   ```

3. Jalankan skrip sesuai kebutuhan:

   - Untuk instalasi database:
     ```bash
     ./install-database.sh
     ```
   - Untuk backup database:
     ```bash
     ./backup-database.sh
     ```
   - Untuk restore database:
     ```bash
     ./restore-database.sh
     ```
   - Untuk pengecekan status:
     ```bash
     ./check-status.sh
     ```

4. Ikuti petunjuk interaktif yang ditampilkan oleh skrip.

## Alur Skrip
1. **Instalasi Database:**
   - Update sistem.
   - Instal database yang dipilih.
   - Konfigurasi aksesibilitas dan kredensial.
   - Opsional membuat database awal.

2. **Backup Database:**
   - Backup MySQL/MariaDB ke file `.sql` menggunakan `mysqldump`.
   - Backup MongoDB ke direktori dengan `mongodump`.

3. **Restore Database:**
   - Restore MySQL/MariaDB dari file `.sql` menggunakan `mysql`.
   - Restore MongoDB dari direktori backup dengan `mongorestore`.

4. **Pengecekan Status Database:**
   - Memastikan layanan database aktif menggunakan `systemctl`.

## Contoh Output
### MySQL/MariaDB Backup
```
Backup berhasil disimpan di nama_database_backup_2024-12-31.sql
```

### MongoDB Backup
```
Backup berhasil disimpan di nama_database_backup_2024-12-31
```

### Status Database
```
Layanan mysql sedang berjalan.
Layanan mongodb tidak berjalan.
```

