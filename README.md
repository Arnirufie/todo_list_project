# 📘 To-Do List App (Flutter + Laravel API)

Aplikasi To-Do List ini dibuat menggunakan **Flutter** sebagai frontend dan **Laravel** sebagai backend (API). Aplikasi ini membantu pengguna dalam mencatat, mengatur, dan mengelola tugas harian. Fitur utama meliputi register-login, CRUD task, filter tugas, dan otentikasi token menggunakan Laravel Sanctum.

---

## 📂 Struktur Folder Repositori

```
todo_list_project/
├── todo_flutter/             # Frontend (Flutter)
├── todo_backend_laravel/     # Backend/API (Laravel)
├── database/
│   └── todo_list.sql         # File SQL hasil export dari phpMyAdmin
└── README.md
```

---

## 🖼️ Halaman Aplikasi

- Halaman Login
- Halaman Register
- Halaman Daftar Tugas (To-Do List)
- Form Tambah Tugas
- Fitur Checklist tugas selesai
- Menu: My Day, Completed, All Tasks, Important

---

## 🗃️ DB yang Digunakan

- **Jenis Database:** MySQL (via Laragon/XAMPP)
- **Nama Database:** `todo_list_db`
- **Tabel:** `users`, `tasks`
- File database: `todo_list.sql` (ada di folder `database/`)

---

## 🔌 API (Laravel)

Semua endpoint menggunakan middleware `auth:sanctum`.

| Endpoint           | Method | Deskripsi                         |
|--------------------|--------|------------------------------------|
| `/api/register`    | POST   | Register user baru                 |
| `/api/login`       | POST   | Login user dan dapatkan token      |
| `/api/tasks`       | GET    | Menampilkan semua tugas            |
| `/api/tasks`       | POST   | Tambah tugas baru                  |
| `/api/tasks/{id}`  | PUT    | Edit tugas berdasarkan ID          |
| `/api/tasks/{id}`  | DELETE | Hapus tugas berdasarkan ID         |

---

## 💻 Software yang Digunakan

| Bagian     | Teknologi               |
|------------|--------------------------|
| Frontend   | Flutter v3.27.3          |
| Backend    | Laravel v12.16.0         |
| Bahasa     | Dart v3.6.1, PHP         |
| Database   | MySQL via Laragon/XAMPP  |

---

## 🛠️ Cara Instalasi

### 🔹 Laravel (Backend)

```bash
cd todo_backend_laravel
composer install
cp .env.example .env
php artisan key:generate
```

Edit file `.env`:

```
DB_DATABASE=todo_list
DB_USERNAME=root
DB_PASSWORD=
```

Import database:

1. Buka phpMyAdmin  
2. Buat database baru dengan nama `todo_list`  
3. Import file `todo_list.sql` dari folder `database/`

Jalankan migrasi dan server Laravel:

```bash
php artisan migrate
php artisan serve
```

---

### 🔹 Flutter (Frontend)

```bash
cd todo_flutter
flutter pub get
flutter run
```

> Pastikan emulator atau device sudah aktif sebelum menjalankan.

---

## ▶️ Cara Menjalankan

1. Jalankan Laravel dengan `php artisan serve atau php artisan serve --host=0.0.0.0 --port=8000`  
2. Jalankan Flutter dengan `flutter run`  
3. Aplikasi akan membuka halaman Login atau Register  
4. Setelah login, akan tampil halaman daftar tugas  
5. Pastikan base URL di Flutter sesuai dengan alamat backend  
   (`http://127.0.0.1:8000` atau `http://10.0.2.2:8000` untuk emulator Android)

---

## 📹 Demo Aplikasi

📺 [Demo Aplikasi (Google Drive)](https://drive.google.com/file/d/1d9ApUbrSlqZuTWZTMZU7sj2-x4dBlKqQ/view?usp=drive_link)

---

## 👤 Identitas Pembuat

- **Nama:** Arni Rufiyanti  
- **Kelas:** XI RPL1  
- **Mapel:** Pemrograman Perangkat Bergerak  
- **Instagram:** [@rufie.aa](https://instagram.com/rufie.aa)
