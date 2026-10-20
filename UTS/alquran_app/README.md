# Al-Qur'an Digital

Aplikasi mobile berbasis Flutter untuk membaca daftar surah Al-Qur'an beserta ayat, teks Latin, dan terjemahan Bahasa Indonesia. Data diambil secara dinamis dari API publik [EQuran.id](https://equran.id).

Proyek ini dibuat untuk memenuhi tugas Ujian Tengah Semester (UTS) mata kuliah Pemrograman Mobile.

## Deskripsi Singkat

Al-Qur'an Digital menampilkan 114 surah dalam satu daftar yang dapat dicari. Pengguna dapat membuka salah satu surah untuk membaca seluruh ayatnya lengkap dengan teks Arab, transliterasi Latin, dan terjemahan Indonesia. Semua data berasal dari API, tidak ada data yang ditulis langsung di dalam kode.

## Fitur Utama

- Daftar 114 surah (nomor, nama Latin, nama Arab, arti, jumlah ayat, dan tempat turun).
- Pencarian surah berdasarkan nama, arti, atau nomor.
- Halaman detail surah berisi seluruh ayat: teks Arab, teks Latin, dan terjemahan Indonesia.
- Deskripsi singkat tiap surah pada halaman detail.
- Penanganan tiga kondisi pengambilan data dengan `FutureBuilder`: loading, success, dan error (dilengkapi tombol "Coba Lagi").
- Pesan kesalahan yang jelas untuk kasus tanpa internet, waktu habis, status server bukan 200, dan JSON tidak valid.
- Pengujian otomatis (unit test dan widget test).

## Teknologi dan Package

| Teknologi / Package | Kegunaan |
|---|---|
| Flutter dan Dart | Framework dan bahasa pemrograman aplikasi |
| [`http`](https://pub.dev/packages/http) | Mengirim permintaan HTTP ke API (juga `MockClient` untuk pengujian) |
| `flutter_test` | Unit test dan widget test |
| `flutter_lints` | Aturan analisis kode |
| API EQuran.id v2 | Sumber data surah dan ayat |

Endpoint yang digunakan:

- Daftar surah: `GET https://equran.id/api/v2/surat`
- Detail surah: `GET https://equran.id/api/v2/surat/{nomor}`

## Struktur Folder

```
lib/
├── main.dart                     # Titik masuk aplikasi
├── models/
│   ├── surah.dart                # Model surah (daftar)
│   └── surah_detail.dart         # Model detail surah dan ayat
├── services/
│   └── quran_api_service.dart    # Permintaan HTTP dan penanganan error
├── pages/
│   ├── surah_list_page.dart      # Halaman daftar surah + pencarian
│   └── surah_detail_page.dart    # Halaman detail dan ayat
├── widgets/
│   └── state_views.dart          # Tampilan loading dan error
└── utils/
    └── text_utils.dart           # Pembersih tag HTML
test/
└── quran_app_test.dart           # Unit test dan widget test
```

## Langkah Menjalankan Aplikasi

Prasyarat: [Flutter SDK](https://docs.flutter.dev/get-started/install) sudah terpasang, serta emulator atau perangkat Android/iOS (atau Chrome untuk web).

1. Clone repositori:
   ```bash
   git clone <url-repositori-ini>
   cd alquran_app
   ```
2. Pasang dependensi:
   ```bash
   flutter pub get
   ```
3. Jalankan aplikasi (pastikan perangkat terhubung dan memiliki koneksi internet):
   ```bash
   flutter run
   ```
4. (Opsional) Jalankan pengujian:
   ```bash
   flutter test
   ```

> Catatan untuk build release Android: tambahkan izin internet pada `android/app/src/main/AndroidManifest.xml`:
> `<uses-permission android:name="android.permission.INTERNET" />`

## Sumber Data

Data surah dan ayat disediakan oleh [EQuran.id](https://equran.id).
