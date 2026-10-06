# Dokumen Kebutuhan Data - Sistem Informasi Perpustakaan Sejahtera

- **Disusun oleh:** Aditya Rizaldiansyah
- **NIM:** 25430001
- **Kelas:** A
- **Mata kuliah:** Praktikum Basis Data
- **Jenis dokumen:** Dokumen Kebutuhan Data Modul 2 (Sistem Informasi Perpustakaan)

---

## 1. Latar belakang dan aktivitas organisasi

Perpustakaan Sejahtera mengelola koleksi buku, literatur ilmiah, dan ruang baca di lingkungan kampus. Pengguna layanan terdiri dari mahasiswa, dosen, dan staf umum. Kegiatan operasional utama perpustakaan mencakup pendaftaran keanggotaan, sirkulasi peminjaman dan pengembalian buku, perhitungan denda keterlambatan, pengadaan koleksi baru dari penerbit/pemasok, penukaran poin keaktifan membaca, serta penyusunan laporan statistik sirkulasi bulanan.

---

## 2. Aktor dan proses bisnis

| Kode | Proses bisnis | Aktor | Pemicu |
|---|---|---|---|
| PB-01 | Mendaftarkan anggota | Pustakawan (atas permintaan pemohon) | Mahasiswa/Dosen ingin menjadi anggota perpustakaan |
| PB-02 | Mencatat peminjaman buku | Pustakawan | Anggota memilih buku dan mengajukan pinjaman di meja sirkulasi |
| PB-03 | Mencatat pengembalian & denda | Pustakawan | Anggota mengembalikan buku yang dipinjam |
| PB-04 | Memesan pengadaan buku baru | Petugas Pengadaan | Jumlah eksemplar/koleksi buku tertentu kurang atau ada usulan baru |
| PB-05 | Menerima pasokan buku baru | Petugas Pengadaan | Buku pesanan datang bersama faktur dari penerbit/pemasok |
| PB-06 | Mengelola data penerbit/pemasok | Petugas Pengadaan | Terdapat penerbit/pemasok baru atau perubahan data kontak |
| PB-07 | Memperbarui status keanggotaan | Kepala Perpustakaan | Anggota lulus, masa berlaku habis, atau melakukan pelanggaran berat |
| PB-08 | Menukar poin keaktifan baca | Pustakawan (atas permintaan anggota) | Anggota aktif memiliki saldo minimal 50 poin dan meminta penukaran bebas denda/suvenir |
| PB-09 | Mengelola data katalog buku | Pustakawan / Petugas Pengadaan | Buku baru siap dikatalogkan atau ada perubahan data informasi buku |
| PB-10 | Menyusun laporan sirkulasi bulanan | Kepala Perpustakaan | Awal bulan |

---

## 3. Dokumen sumber yang dianalisis

Dokumen sumber utama yang dianalisis adalah **slip peminjaman dan pengembalian buku**. Setiap isian pada slip diperlakukan sebagai kandidat elemen data.

| Elemen pada slip | Disimpan / Dihitung | Keterangan |
|---|---|---|
| Nomor transaksi pinjam | Disimpan | Penanda unik setiap transaksi sirkulasi |
| Tanggal pinjam & jatuh tempo | Disimpan | Penentu batas waktu pengembalian buku |
| Pustakawan / Petugas | Disimpan | Petugas sirkulasi yang melayani |
| Identitas anggota (NIM/ID) | Disimpan | Menandai anggota peminjam |
| Kode & judul buku | Disimpan | Per baris detail buku yang dipinjam |
| Qty (Jumlah eksemplar) | Disimpan | Jumlah eksemplar buku yang dipinjam |
| Tanggal dikembalikan | Disimpan | Catatan waktu aktual buku kembali |
| Keterlambatan (Hari) | Dihitung | Selisih tanggal kembali dengan tanggal jatuh tempo |
| Tarif denda per hari | Disimpan | Mengikuti aturan denda saat transaksi terjadi |
| Total denda | Dihitung | Jumlah hari keterlambatan x tarif denda per hari |

---

## 4. Entitas kandidat dan elemen data

| Entitas kandidat | Elemen data utama | Sumber |
|---|---|---|
| Anggota | id_anggota, nim_anggota, nama_anggota, prodi, no_hp, status_aktif, tgl_daftar | Formulir pendaftaran |
| Buku | id_buku, ISBN, judul_buku, pengarang, penerbit, tahun_terbit, stok_tersedia | Katalog buku, faktur |
| Peminjaman | id_peminjaman, tgl_pinjam, tgl_jatuh_tempo, id_anggota, id_petugas | Slip peminjaman |
| Detail Peminjaman | id_detail, id_peminjaman, id_buku, qty, status_kembali | Slip peminjaman |
| Pengembalian & Denda | id_pengembalian, id_peminjaman, tgl_kembali, hari_terlambat, total_denda | Slip pengembalian / Kuitansi |
| Petugas | id_petugas, nama_petugas, peran (sirkulasi/pengadaan/kepala) | Wawancara internal |
| Penerbit / Pemasok | id_pemasok, nama_pemasok, no_telepon, alamat | Faktur pengadaan |
| Pengadaan & Detail | id_pengadaan, tgl_pengadaan, id_pemasok, id_buku, qty_beli, harga_beli | Faktur pengadaan |
| Transaksi Poin Baca | id_transaksi_poin, id_anggota, id_peminjaman, tgl_transaksi, jenis_transaksi, jumlah_poin | Skenario program literasi |

**Catatan pemisahan Peminjaman dan Detail peminjaman:** data yang muncul sekali per transaksi (nomor transaksi, tanggal pinjam, jatuh tempo, pustakawan, anggota) dipisahkan dari data yang berulang per baris buku (id_buku, qty, status kembali), karena satu transaksi peminjaman dapat memuat beberapa judul buku yang berbeda.

---

## 5. Aturan bisnis

| Kode | Aturan bisnis | Asal |
|---|---|---|
| AB-01 | Setiap transaksi peminjaman memiliki ID unik dan mencakup minimal satu judul buku. | Slip peminjaman |
| AB-02 | Peminjaman hanya diperbolehkan untuk Anggota dengan status aktif dan tidak memiliki denda terutang. | Kebijakan sirkulasi |
| AB-03 | Maksimal buku yang dapat dipinjam oleh satu anggota dalam satu waktu adalah 3 eksemplar; peminjaman ditolak jika stok buku 0. | Kebijakan sirkulasi |
| AB-04 | Tarif denda keterlambatan yang dicatat pada transaksi pengembalian mengunci tarif saat kejadian dan tidak berubah jika aturan denda naik. | Kebijakan denda |
| AB-05 | NIM anggota bersifat unik; pencarian data anggota dapat dilakukan via ID anggota atau NIM. | Keluhan pustakawan |
| AB-06 | Pengadaan buku baru dipicu jika stok buku berada di bawah batas minimum. | Pemicu PB-04 |
| AB-07 | Setiap pengembalian buku tepat waktu dari transaksi peminjaman menghasilkan 5 poin keaktifan membaca bagi anggota aktif. | Program literasi |
| AB-08 | Sebanyak 50 poin keaktifan dapat ditukar dengan pembebasan denda maksimal Rp5.000 atau suvenir perpustakaan. | Program literasi |
| AB-09 | Penukaran poin hanya dapat dilakukan oleh anggota aktif dengan saldo minimal 50 poin. | Asumsi operasional |
| AB-10 | Setiap penukaran poin dicatat sebagai transaksi penukaran dan mengurangi saldo poin anggota sebanyak 50 poin. | Asumsi operasional |
| AB-11 | Pembebasan denda via poin dan diskon denda lainnya tidak dapat digabungkan dalam satu transaksi pengembalian. | Asumsi operasional |

---

## 6. Kebutuhan informasi

| Kode | Kebutuhan informasi | Data yang diperlukan |
|---|---|---|
| KI-01 | Total frekuensi peminjaman dan pengembalian buku per bulan | Peminjaman, Detail Peminjaman |
| KI-02 | Lima buku paling sering dipinjam (*top-borrowed*) per semester | Detail Peminjaman, Buku |
| KI-03 | Daftar koleksi buku dengan sisa stok di bawah batas minimum | Buku |
| KI-04 | Rekapitulasi penerimaan denda keterlambatan per bulan | Pengembalian & Denda |
| KI-05 | Daftar peminjaman yang melewati batas jatuh tempo (menunggak) | Peminjaman, Anggota, Detail Peminjaman |
| KI-06 | Sepuluh anggota paling aktif meminjam buku dan perolehan poin per semester | Transaksi Poin, Anggota, Peminjaman |

---

## 7. Matriks CRUD

| Proses | Anggota | Buku | Peminjaman | Detail | Pengembalian | Pemasok | Pengadaan | Transaksi Poin |
|---|---|---|---|---|---|---|---|---|
| PB-01 Daftar anggota | C | | | | | | | |
| PB-02 Catat peminjaman | R | R, U | C | C | | | | C |
| PB-03 Catat pengembalian & denda | R | R, U | R, U | R, U | C | | | C |
| PB-04 Memesan pengadaan | | R | | | | R | C | |
| PB-05 Menerima pasokan | | U | | | | R | U | |
| PB-06 Mengelola data pemasok | | | | | | C, U | | |
| PB-07 Memperbarui status anggota | U | | | | | | | |
| PB-08 Menukar poin keaktifan | R | | | | | | | C |
| PB-09 Mengelola data katalog buku | | C, U | | | | | | |
| PB-10 Menyusun laporan bulanan | R | R | R | R | R | | R | R |

**Catatan desain saldo poin:** saldo poin anggota tidak disimpan sebagai kolom tersendiri di tabel `Anggota`, melainkan dihitung secara dinamis dari agregasi riwayat `Transaksi Poin` (total perolehan dikurangi total penukaran). Oleh karena itu, PB-02, PB-03, dan PB-08 hanya membaca (`R`) data Anggota. Transaksi Poin tidak pernah diperbarui (`U`) karena setiap aktivitas dicatat sebagai baris transaksi baru.

**Temuan pemeriksaan matriks:**

**Bagian A — Penerbit / Pemasok**  
Penambahan **PB-06 Mengelola data pemasok** oleh petugas pengadaan memberikan akses `C` dan `U` pada entitas `Pemasok` agar data mitra penerbit/pemasok sudah tercatat sebelum proses pengadaan (PB-04/PB-05) membaca (`R`) data tersebut.

**Bagian B — Status Anggota**  
Penambahan **PB-07 Memperbarui status keanggotaan** oleh kepala perpustakaan memberikan akses `U` pada entitas `Anggota` untuk mengakomodasi perubahan status (misalnya mahasiswa lulus, non-aktif, atau terkena sanksi).

**Bagian C — Katalog Buku**  
Penambahan **PB-09 Mengelola data katalog buku** memastikan entitas `Buku` memiliki operasi `C` saat ada judul buku baru yang dimasukkan ke sistem dan `U` saat informasi buku atau harga/stok diperbarui.

---

## 8. Kamus data awal

| Elemen | Arti | Contoh | Aturan | Penanggung jawab |
|---|---|---|---|---|
| id_anggota | Nomor anggota perpustakaan | AG-2501 | Unik, format AG-4 digit | Pustakawan |
| nim_anggota | NIM anggota mahasiswa | 25430001 | Unik, 8 digit (AB-05) | Pustakawan |
| no_hp_anggota | Nomor HP anggota | 08123456789 | Data pribadi, akses terbatas | Pustakawan |
| id_peminjaman | Kode unik transaksi pinjam | PJ-2610-001 | Unik per transaksi (AB-01) | Pustakawan |
| tgl_jatuh_tempo | Batas akhir pengembalian | 2026-10-13 | Format tanggal valid | Pustakawan |
| stok_tersedia | Jumlah eksemplar di rak | 3 | Bilangan bulat >= 0 (AB-03) | Petugas pengadaan |
| id_transaksi_poin | Identitas unik transaksi poin | TP-1001 | Unik | Pustakawan |
| id_anggota_poin | Anggota pemilik transaksi poin | AG-2501 | Mengacu ke anggota yang valid | Pustakawan |
| id_peminjaman_poin | Transaksi yang terkait dengan poin | PJ-2610-001 | Mengacu ke peminjaman yang valid | Pustakawan |
| tgl_transaksi_poin | Tanggal perolehan/penukaran poin | 2026-10-06 | Format tanggal valid | Pustakawan |
| jenis_transaksi_poin | Kategori aktivitas poin | perolehan | Hanya 'perolehan' atau 'penukaran' | Pustakawan |
| jumlah_poin | Nilai poin transaksi | 5 | Bilangan bulat > 0 (AB-07, AB-10) | Pustakawan |

---

## 9. Kebutuhan non-fungsional data

| Jenis | Ketentuan |
|---|---|
| Volume | Perkiraan +/- 100-200 transaksi peminjaman/pengembalian per hari |
| Retensi | Data riwayat peminjaman dan denda disimpan minimal 5 tahun untuk audit akademik |
| Privasi | Nomor telepon dan riwayat bacaan anggota bersifat rahasia dan hanya diakses oleh pustakawan/kepala perpustakaan |

---

## 10. Isu kualitas data yang diantisipasi

1. **Ketidaksesuaian Stok Eksemplar Buku (Akurasi)**  
   Data stok di sistem dapat berbeda dengan kondisi riil jika ada buku rusak/hilang tanpa pencatatan. Diantisipasi dengan fitur *stock opname* berkala dan konstrain `CHECK (stok_tersedia >= 0)`.

2. **Perubahan Tarif Denda Historis (Ketepatan Historis)**  
   Jika tarif denda harian dinaikkan di masa depan, hitungan denda pada transaksi pengembalian lama tidak boleh berubah. Nominal total denda dikunci dan disimpan permanen pada tabel `Pengembalian & Denda`.

3. **Anggota Lupa Membawa Kartu Anggota (Kemudahan Identifikasi)**  
   Pustakawan memerlukan mekanisme pencarian yang fleksibel di kasir sirkulasi menggunakan NIM atau nama anggota untuk menghindari kesalahan pemilihan identitas peminjam.