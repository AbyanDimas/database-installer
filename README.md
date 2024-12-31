# Script Instalasi Database

## Deskripsi
Repository ini berisi script Bash untuk mengotomatisasi instalasi dan konfigurasi database populer: MySQL, MariaDB, dan MongoDB. Script ini memungkinkan pengaturan cepat dan menyediakan opsi untuk mengkonfigurasi pengguna database, kata sandi, dan database awal secara interaktif.

## Fitur
- Menginstal dan mengkonfigurasi MySQL, MariaDB, atau MongoDB.
- Prompt interaktif untuk kredensial pengguna database dan aksesibilitas.
- Opsi pembuatan database awal untuk MySQL dan MariaDB.
- Konfigurasi firewall otomatis untuk akses database.

## Prasyarat
- Sistem berbasis Linux (diuji pada Ubuntu).
- Akses `sudo` untuk menjalankan perintah instalasi.

## Cara Penggunaan
1. Clone repository:
   ```bash
   git clone https://github.com/abyandimas/database-installer.git
   cd database-installer
   ```

2. Jadikan script dapat dieksekusi:
   ```bash
   chmod +x install-database.sh
   ```

3. Jalankan script:
   ```bash
   ./install-database.sh
   ```

4. Ikuti prompt interaktif untuk memilih database, mengkonfigurasi kredensial, dan membuat database awal (opsional).

## Alur Kerja Script
1. **Update Sistem:** Memastikan paket sistem Anda diperbarui.
2. **Pemilihan Database:** Memungkinkan Anda memilih antara MySQL, MariaDB, dan MongoDB.
3. **Pengaturan Pengguna dan Kata Sandi:** Prompt untuk nama pengguna dan kata sandi untuk MySQL/MariaDB.
4. **Aksesibilitas Database:** Opsi untuk mengkonfigurasi akses publik atau privat.
5. **Pembuatan Database Awal:** Langkah opsional untuk MySQL/MariaDB.
6. **Konfigurasi Firewall:** Membuka port yang diperlukan secara otomatis.

## Database yang Didukung
### MySQL
- Menginstal server MySQL.
- Mengkonfigurasi `bind-address` untuk akses jarak jauh.
- Memberikan hak akses kepada pengguna yang ditentukan.

### MariaDB
- Menginstal server MariaDB.
- Mengkonfigurasi `bind-address` untuk akses jarak jauh.
- Memberikan hak akses kepada pengguna yang ditentukan.

### MongoDB
- Menginstal server MongoDB.
- Mengaktifkan dan memulai layanan MongoDB.

## Contoh Output
### MySQL/MariaDB
```
Database telah berhasil diinstal dan dikonfigurasi.

Petunjuk untuk mengakses database:
- Gunakan MySQL/MariaDB Client:
  mysql -u username -p -h [IP_SERVER]
  Masukkan password saat diminta.
```

### MongoDB
```
Database telah berhasil diinstal dan dikonfigurasi.

Petunjuk untuk mengakses database:
- Gunakan Mongo Shell:
  mongo --host [IP_SERVER]
```

## Kontak
Untuk pertanyaan silahkan ke menu issues
