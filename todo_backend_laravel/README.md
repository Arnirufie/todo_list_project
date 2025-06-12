# To-Do List App

Aplikasi to-do list sederhana dengan fitur login register daftar tugas harian, penandaan penting, dan perencanaan tugas. Dibangun menggunakan:

* 💻 **Laravel** (PHP) sebagai REST API Backend
* 📱 **Flutter** (Dart) sebagai Frontend Mobile App

---

## 🚀 Fitur Utama

* Tambah, edit, hapus tugas
* Tandai tugas sebagai penting
* Filter tugas berdasarkan kategori: `My Day`, `Important`, `Planned`, `All Tasks`

---

## 🧰 Teknologi

| Bagian   | Teknologi      |
| -------- | -------------- |
| Backend  | Laravel 11 (PHP ) |
| Frontend | Flutter (Dart) |
| Database | MySQL          |

---

## 🔧 Instalasi

### 🔹 Backend (Laravel API)

1. Download folder todo\_list.zip
   [https://drive.google.com/file/d/1IOsgkRqzgkYwD3iCr-nfRZrC75THLfjp/view?usp=sharing](https://drive.google.com/file/d/1IOsgkRqzgkYwD3iCr-nfRZrC75THLfjp/view?usp=sharing)
2. Ekstrak folder todo\_list.zip
3. Buka folder tersebut di **VS Code**
4. Jalankan perintah berikut:

   ```bash
   composer install
   cp .env.example .env
   php artisan key:generate
   # Edit konfigurasi database di .env
   php artisan migrate
   php artisan serve
   ```

### 🔹 Frontend (Flutter App)

1. Download folder todo\_flutter.zip
   [https://drive.google.com/file/d/19voCHt\_tIz\_1-06rMmAPGb0HLxOsxcCQ/view?usp=drive\_link](https://drive.google.com/file/d/19voCHt_tIz_1-06rMmAPGb0HLxOsxcCQ/view?usp=drive_link)
2. Ekstrak folder todo\_flutter.zip
3. Buka folder tersebut di **VS Code**
4. Jalankan perintah berikut:

   ```bash
   flutter pub get
   flutter run
   ```

---

## 🎬 Demo

[https://drive.google.com/file/d/1p1CoupaNc2Ml4ZhXvmd80-2wfopRwgiU/view?usp=sharing](https://drive.google.com/file/d/1p1CoupaNc2Ml4ZhXvmd80-2wfopRwgiU/view?usp=sharing)

---

## 👤 Authors

* [@Arnirufie](https://github.com/Arnirufie)
* [@Instagram](https://instagram.com)

---

## 📄 License

This project is open-source and available under the [MIT License](LICENSE).
