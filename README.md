# Suitmedia Intern Technical Test

Aplikasi ujian teknis (*technical test*) untuk program magang Suitmedia, dibangun menggunakan **Flutter** dengan pendekatan arsitektur **MVVM (Model-View-ViewModel)** dan manajemen state **GetX**.

## 📱 Deskripsi Aplikasi

Aplikasi ini terdiri dari 3 layar utama (sesuai spesifikasi UI/UX):

1. **First Screen (Authenticate)**: Memiliki fitur validasi form nama dan pengecekan *Palindrome*.
2. **Second Screen (Dashboard)**: Menampilkan nama pengguna yang diinput dari layar pertama, dan tombol untuk memilih pengguna dari layar ketiga.
3. **Third Screen (Userprofile)**: Menampilkan daftar pengguna (avatar, nama depan, nama belakang, email) yang diambil dari REST API (`https://reqres.in/api/users`) menggunakan fitur *pagination* (halaman dan *pull-to-refresh*).

## 🛠️ Teknologi & *Packages* Utama

- **[GetX](https://pub.dev/packages/get)**: Digunakan untuk *State Management*, *Dependency Injection* (`BindingsBuilder`), dan navigasi halaman (`Get.toNamed()`).
- **[Dio](https://pub.dev/packages/dio)**: HTTP client tangguh untuk mengelola *request* API (GET *users* dari ReqRes).
- **[Flutter Dotenv](https://pub.dev/packages/flutter_dotenv)**: Manajemen konfigurasi rahasia (*Environment Variables*) untuk *API Key* dan *Base URL*.
- **[Cached Network Image](https://pub.dev/packages/cached_network_image)**: Menampilkan gambar avatar pengguna secara asinkron dengan fitur *caching*.
- **[Google Fonts](https://pub.dev/packages/google_fonts)**: Untuk menggunakan tipe huruf Poppins secara dinamis tanpa perlu mengunduh file `.ttf` secara manual.

## 🏗️ Struktur Arsitektur (MVVM)

Aplikasi ini menerapkan pemisahan tugas yang jelas (*Separation of Concerns*) agar kode lebih mudah dites, diperbarui, dan dibaca:

- **`lib/views/` (View)**: Hanya berisi komponen antarmuka pengguna (*Widgets*) dan sama sekali tidak memiliki logika pemrosesan data (semua _state_ diambil dengan `Obx` atau `GetView`).
- **`lib/viewmodels/` (ViewModel)**: Merupakan kelas pengontrol (`GetxController`) yang bertugas menyiapkan data untuk View, serta menangani aksi (seperti pengecekan Palindrome atau pemanggilan *repository*).
- **`lib/data/` (Model/Repository)**: Berisi model data mentah (`UserModel`) dan logika untuk mengambil data pihak ketiga (`UserRepository` yang memanggil Dio).
- **`lib/core/`**: Menyimpan tema aplikasi (`app_colors.dart`) dan konfigurasi API (`api_config.dart` yang memuat `.env`).

## 🚀 Cara Menjalankan (*Getting Started*)

### 1. Instalasi

Pastikan Anda sudah menginstal **Flutter SDK** versi terbaru.
Clone *repository* ini lalu jalankan perintah berikut di terminal:

```bash
flutter pub get
```

### 2. Konfigurasi Lingkungan (*Environment*)

Karena aplikasi ini menggunakan `.env` untuk keamanan data, Anda perlu membuat file konfigurasi secara lokal:

1. Salin/duplikasi file `.env.example` yang ada di *root directory*.
2. Ubah namanya menjadi `.env`.
3. Pastikan isi filenya seperti ini (dan masukkan API Key Anda jika ada):

```env
BASE_URL=https://reqres.in/api
API_KEY='Enter_Your_Key_Here'
```

### 3. Menjalankan Aplikasi

Anda dapat menjalankannya di emulator (Android/iOS) atau perangkat fisik menggunakan perintah:

```bash
flutter run
```

---

*Dibuat untuk keperluan penilaian Suitmedia Technical Test App.*
