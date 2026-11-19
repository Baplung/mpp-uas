# 🏝️ LokaTrip — UAS Mobile Programming Practicum

> **LokaTrip** adalah aplikasi mobile berbasis Flutter untuk panduan, rekomendasi, dan manajemen rencana perjalanan wisata lokal Indonesia yang dilengkapi dengan pelacakan lokasi GPS dinamis, prakiraan cuaca lokal terintegrasi, notifikasi sistem interaktif, dan penjadwalan itinerary perjalanan terpadu.

Aplikasi ini merupakan pengembangan lanjutan dari proyek UTS sesuai ketentuan UAS Mobile Programming Practicum 2026/2027.

---

## 🌟 Fitur Baru & Peningkatan (UTS ke UAS)

| No | Fitur / Komponen | Deskripsi di UTS | Pembaruan di UAS |
|---|---|---|---|
| 1 | **Jumlah Halaman Utama** | 3 Halaman (*Beranda, Eksplorasi, Tersimpan*) | **4 Halaman Utama + 1 Detail** (Penambahan tab *Jadwal / Rencana Wisata*) |
| 2 | **Lokasi & Jarak Pengguna** | Statis / Belum ada perhitungan jarak | **Dinamis Realtime (Haversine Formula)** dengan pilihan multi-koordinat kota & estimasi jarak akurat |
| 3 | **Prakiraan Cuaca Lokal** | Belum ada fitur informasi cuaca | **Prakiraan Cuaca & Suhu Tiap Destinasi** lengkap dengan ikon kondisi dan tips bepergian |
| 4 | **Pusat Notifikasi Interaktif** | Lonceng statis | **Sistem Notifikasi Lengkap (Bottom Sheet)** untuk info cuaca darurat, pengingat jadwal, dan pembaruan GPS |
| 5 | **Manajemen Rencana Wisata (Itinerary)** | Belum ada | **Halaman Rencana Wisata Interaktif**: Tambah jadwal dengan date/time picker, estimasi biaya, catatan, dan checkbox checklist |
| 6 | **Integrasi Aksi Detail** | Tombol aksi statis | **Tombol "Jadwalkan Tour"** langsung membuka modal form penjadwalan dan terhubung ke tab Rencana Wisata |

---

## 🏗️ Arsitektur Proyek Modular

```text
lib/
├── main.dart                          # Entry point aplikasi & re-export
├── app/
│   └── lokatrip_app.dart              # Konfigurasi MaterialApp, tema warna & font
├── models/
│   ├── destination.dart               # Model destinasi (koordinat, cuaca, rating, harga)
│   ├── itinerary.dart                 # Model jadwal perjalanan (tanggal, waktu, biaya, status)
│   ├── notification_item.dart         # Model notifikasi (cuaca, jadwal, info sistem)
│   └── user_location.dart             # Model lokasi GPS & formula Haversine jarak dinamis
├── data/
│   └── destinations.dart              # Dataset kurasi 4 destinasi nusantara
├── screens/
│   ├── main_shell.dart                # Shell navigasi 4 tab, state manajemen terpadu
│   ├── home_page.dart                 # Beranda, greeting, hero banner, status GPS, notifikasi
│   ├── explore_page.dart              # Pencarian instan, filter chip kategori, jarak dinamis
│   ├── itinerary_page.dart            # [BARU UAS] Halaman manajemen jadwal rencana wisata
│   ├── saved_page.dart                # Koleksi destinasi tersimpan (bookmark)
│   └── detail_page.dart               # Detail destinasi, cuaca lokal, aksi jadwal tour
└── widgets/
    ├── category_tile.dart             # Komponen tile kategori ber-subtitle
    ├── destination_card.dart          # Kartu destinasi ber-badge cuaca & jarak GPS dinamis
    ├── location_picker_dialog.dart    # [BARU UAS] Bottom sheet pengubah lokasi dinamis
    └── notifications_sheet.dart       # [BARU UAS] Bottom sheet pusat notifikasi & alert
```

---

## 📱 Panduan Menjalankan Aplikasi

Pastikan Flutter SDK (^3.13 / ^3.14) sudah terpasang.

1. **Unduh dependensi**:
   ```bash
   flutter pub get
   ```

2. **Jalankan analisis kode & pengujian unit**:
   ```bash
   flutter analyze
   flutter test
   ```

3. **Jalankan di emulator/device**:
   ```bash
   flutter run
   ```

4. **Jalankan di Google Chrome (Web)**:
   ```bash
   flutter run -d chrome
   ```

---

## 👨‍💻 Identitas Mahasiswa

- **Nama**: Ghazy Praba Aryasatya
- **NIM**: 240605110099
- **Mata Kuliah**: Mobile Programming Practicum
- **Dosen Pengampu**: Khadijah Fahmi Hayati Holle, S.Kom., M.Kom
- **Program Studi**: Teknik Informatika, UIN Maulana Malik Ibrahim Malang
