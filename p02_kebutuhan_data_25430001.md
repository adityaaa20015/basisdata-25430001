# DOKUMEN KEBUTUHAN DATA – NEXUS PUSTAKA AR

- **Disusun oleh:** Aditya Rizaldiansyah
- **NIM:** 25430001
- **Kelas:** A
- **Mata kuliah:** Praktikum Basis Data
- **Milestone:** [Proyek/Pertemuan]
- **Tema:** Perpustakaan
- **Kode tema:** `perpus`

---

## 1. Latar Belakang dan Aktivitas Organisasi

Nexus Pustaka AR adalah perpustakaan kampus yang melayani mahasiswa aktif. Perpustakaan ini menyediakan berbagai macam koleksi bacaan yang dapat digunakan mahasiswa untuk mendukung kegiatan belajar maupun sebagai bahan bacaan, seperti novel, komik, jurnal ilmiah, dan buku kuliah.

Mahasiswa yang ingin menggunakan layanan perpustakaan harus terdaftar sebagai anggota terlebih dahulu. Setelah terdaftar, mahasiswa dapat melakukan peminjaman dan pengembalian buku sesuai dengan aturan yang berlaku di perpustakaan. Data anggota dan riwayat peminjaman juga perlu disimpan agar petugas dapat mengecek aktivitas peminjaman setiap anggota.

Kegiatan utama yang dilakukan di Nexus Pustaka AR meliputi pendaftaran anggota, pengelolaan data buku, peminjaman buku, pengembalian buku, pencatatan denda keterlambatan, pembayaran denda, serta pencatatan usulan buku baru dari mahasiswa.

Dalam kegiatan sehari-hari, petugas perpustakaan harus mencatat transaksi peminjaman dan pengembalian, mengecek ketersediaan buku, memperbarui status buku, mencatat denda, dan memeriksa riwayat peminjaman anggota. Jika pencatatan dilakukan secara manual atau tidak teratur, petugas akan lebih sulit mencari data transaksi, mengetahui buku yang masih dipinjam, dan memastikan jumlah denda yang harus dibayar oleh anggota.

Oleh karena itu, diperlukan pengelolaan data yang lebih teratur melalui database agar data anggota, buku, transaksi peminjaman, pengembalian, denda, dan usulan buku dapat disimpan serta dicari kembali dengan lebih mudah.

### Aktivitas Utama Organisasi

Aktivitas yang dilakukan di Nexus Pustaka AR antara lain:

1. Pendaftaran mahasiswa sebagai anggota perpustakaan.
2. Pengelolaan data anggota.
3. Pengelolaan data buku dan eksemplar.
4. Pencatatan peminjaman buku.
5. Pencatatan pengembalian buku.
6. Pencatatan keterlambatan dan denda.
7. Penerimaan pembayaran denda.
8. Pencatatan usulan buku baru dari mahasiswa.
9. Pengecekan riwayat transaksi anggota.
10. Penyusunan laporan kegiatan perpustakaan.

---

## 2. Aktor dan Proses Bisnis

### 2.1 Aktor

Aktor yang terlibat dalam kegiatan Nexus Pustaka AR adalah:

| Aktor | Peran |
|---|---|
| Mahasiswa | Menggunakan layanan perpustakaan, melakukan peminjaman, pengembalian, dan mengusulkan buku |
| Petugas Perpustakaan | Mengelola data anggota, buku, peminjaman, pengembalian, denda, dan usulan buku |
| Kepala Perpustakaan | Mengawasi kegiatan perpustakaan dan melihat laporan yang dihasilkan |

### 2.2 Proses Bisnis

| Kode | Proses Bisnis | Aktor | Pemicu |
|---|---|---|---|
| PB-01 | Mendaftarkan anggota | Mahasiswa, Petugas | Mahasiswa ingin menjadi anggota |
| PB-02 | Memperbarui data anggota | Petugas | Ada perubahan data anggota |
| PB-03 | Mengelola data buku | Petugas | Ada buku baru atau perubahan data buku |
| PB-04 | Mengelola data eksemplar | Petugas | Ada buku fisik baru atau perubahan kondisi buku |
| PB-05 | Mencatat peminjaman buku | Mahasiswa, Petugas | Mahasiswa ingin meminjam buku |
| PB-06 | Mencatat pengembalian buku | Mahasiswa, Petugas | Mahasiswa mengembalikan buku |
| PB-07 | Mencatat denda keterlambatan | Petugas | Buku dikembalikan melewati batas waktu |
| PB-08 | Menerima pembayaran denda | Mahasiswa, Petugas | Mahasiswa membayar denda |
| PB-09 | Mencatat usulan buku baru | Mahasiswa, Petugas | Mahasiswa mengusulkan buku |
| PB-10 | Memproses usulan buku | Petugas | Usulan buku perlu diperiksa |
| PB-11 | Mengecek riwayat peminjaman | Petugas | Data riwayat anggota dibutuhkan |
| PB-12 | Menyusun laporan perpustakaan | Petugas, Kepala Perpustakaan | Data transaksi perlu direkap |

---

## 3. Dokumen Sumber yang Dianalisis

### 3.1 Dokumen Sumber

Dokumen yang digunakan sebagai sumber analisis data adalah:

- Formulir pendaftaran anggota
- Slip peminjaman buku
- Bukti pengembalian buku
- Bukti pembayaran denda
- Formulir usulan buku
- Data koleksi buku
- Data anggota

Dokumen tersebut digunakan untuk melihat data apa saja yang diperlukan dan data mana yang perlu disimpan di dalam database.

### 3.2 Rancangan Formulir Pendaftaran Anggota

~~~text
==================================================
              NEXUS PUSTAKA AR
             FORMULIR ANGGOTA
==================================================
No. Anggota      : A-001
Nama Mahasiswa   : [Nama]
NIM Mahasiswa    : [NIM]
Alamat           : [Alamat]
No. HP           : [Nomor HP]
Tanggal Daftar   : [Tanggal]
Status           : Aktif
==================================================
~~~

### 3.3 Rancangan Slip Peminjaman

~~~text
==================================================
              NEXUS PUSTAKA AR
              SLIP PEMINJAMAN
==================================================
No. Peminjaman : PMJ-001
Tanggal        : 07-10-2026
No. Anggota    : A-001
Nama Anggota   : [Nama Mahasiswa]
Kode Petugas   : PTG-001
Petugas        : [Nama Petugas]
--------------------------------------------------
| No | Kode Buku | Judul Buku                   |
|----|-----------|------------------------------|
| 1  | BK-001    | Basis Data                   |
| 2  | BK-005    | Algoritma dan Pemrograman    |
--------------------------------------------------
Jumlah Buku    : 2
Jatuh Tempo    : [Tanggal]
Status         : Dipinjam
--------------------------------------------------
Denda          : Rp [Nominal]
==================================================
~~~

### 3.4 Rancangan Bukti Pengembalian

~~~text
==================================================
              NEXUS PUSTAKA AR
             BUKTI PENGEMBALIAN
==================================================
No. Peminjaman : PMJ-001
No. Anggota    : A-001
Nama Anggota   : [Nama Mahasiswa]
Tanggal Kembali: [Tanggal]
Kode Petugas   : PTG-001
Petugas        : [Nama Petugas]
--------------------------------------------------
| No | Kode Buku | Judul Buku | Status           |
|----|-----------|------------|------------------|
| 1  | BK-001    | Basis Data | Dikembalikan     |
| 2  | BK-005    | Algoritma  | Dikembalikan     |
--------------------------------------------------
Denda          : Rp [Nominal]
Status Denda   : [Lunas/Belum Lunas]
==================================================
~~~

### 3.5 Rancangan Bukti Pembayaran Denda

~~~text
==================================================
              NEXUS PUSTAKA AR
             PEMBAYARAN DENDA
==================================================
No. Denda       : DND-001
No. Peminjaman  : PMJ-001
No. Anggota     : A-001
Nama Anggota    : [Nama Mahasiswa]
Jumlah Denda    : Rp [Nominal]
Tanggal Bayar   : [Tanggal]
Status          : Lunas
Kode Petugas    : PTG-001
==================================================
~~~

### 3.6 Rancangan Formulir Usulan Buku

~~~text
==================================================
              NEXUS PUSTAKA AR
             USULAN BUKU BARU
==================================================
No. Usulan      : USL-001
No. Anggota     : A-001
Nama Mahasiswa  : [Nama Mahasiswa]
Judul Buku      : [Judul Buku]
Pengarang       : [Nama Pengarang]
Alasan Usulan   : [Alasan]
Tanggal Usulan  : [Tanggal]
Status Usulan   : Diajukan
==================================================
~~~

### 3.7 Pembedahan Elemen Data

| Elemen pada Dokumen | Disimpan / Dihitung | Keterangan |
|---|---|---|
| No. Anggota | Disimpan | Digunakan untuk mengidentifikasi anggota |
| Nama Anggota | Ditampilkan dari data lain | Diperoleh dari data anggota |
| NIM Mahasiswa | Disimpan | Digunakan untuk mengidentifikasi mahasiswa |
| Tanggal Daftar | Disimpan | Menunjukkan tanggal pendaftaran anggota |
| No. Peminjaman | Disimpan | Nomor unik transaksi peminjaman |
| Tanggal Peminjaman | Disimpan | Menunjukkan waktu transaksi peminjaman |
| Kode Petugas | Disimpan | Menunjukkan petugas yang menangani transaksi |
| Kode Buku | Disimpan | Menunjukkan buku yang dipinjam |
| Judul Buku | Ditampilkan dari data lain | Diperoleh dari data buku |
| Jumlah Buku | Dihitung | Diperoleh dari jumlah detail peminjaman |
| Tanggal Jatuh Tempo | Disimpan | Batas waktu pengembalian |
| Tanggal Kembali | Disimpan | Diisi ketika buku dikembalikan |
| Hari Terlambat | Dihitung | Diperoleh dari perbedaan tanggal kembali dan jatuh tempo |
| Tarif Denda | Disimpan | Tarif yang berlaku pada transaksi |
| Jumlah Denda | Dihitung dan disimpan | Berdasarkan tarif dan hari keterlambatan |
| Status Denda | Disimpan | Menunjukkan lunas atau belum lunas |
| No. Usulan | Disimpan | Nomor unik usulan buku |
| Status Usulan | Disimpan | Menunjukkan proses usulan buku |

---

## 4. Entitas Kandidat dan Elemen Data

| Entitas Kandidat | Elemen Data Utama | Sumber |
|---|---|---|
| Anggota | id_anggota, no_anggota, nim_mahasiswa, nama_anggota, alamat_anggota, no_hp_anggota, tanggal_daftar, status_anggota | Formulir pendaftaran |
| Buku | id_buku, kode_buku, judul_buku, pengarang_buku, penerbit_buku, tahun_terbit, kategori_buku | Data koleksi |
| Eksemplar | id_eksemplar, kode_eksemplar, id_buku, kondisi_eksemplar, status_eksemplar, tanggal_masuk, asal_perolehan | Data koleksi fisik |
| Petugas | id_petugas, kode_petugas, nama_petugas, no_hp_petugas, status_petugas | Data petugas |
| Peminjaman | id_peminjaman, no_peminjaman, tanggal_jam_peminjaman, id_anggota, id_petugas, status_peminjaman | Slip peminjaman |
| Detail Peminjaman | id_detail_peminjaman, id_peminjaman, id_eksemplar, tanggal_jatuh_tempo, tanggal_kembali, jumlah_perpanjangan | Slip dan pengembalian |
| Denda | id_denda, id_detail_peminjaman, tarif_denda, hari_terlambat, jumlah_denda, status_denda, tanggal_bayar_denda, id_petugas | Bukti denda |
| Usulan Buku | id_usulan, id_anggota, judul_usulan, pengarang_usulan, alasan_usulan, tanggal_usulan, status_usulan | Formulir usulan |

### Catatan Pemisahan Entitas

#### Buku dan Eksemplar

Data **Buku** dan **Eksemplar** dipisahkan karena satu judul buku dapat mempunyai beberapa salinan fisik. Data Buku menyimpan informasi umum seperti judul, pengarang, penerbit, dan tahun terbit. Data Eksemplar menyimpan informasi setiap buku fisik seperti kode eksemplar, kondisi, dan status ketersediaannya.

#### Peminjaman dan Detail Peminjaman

Data **Peminjaman** menyimpan informasi utama transaksi seperti nomor transaksi, tanggal, anggota, dan petugas. Data **Detail Peminjaman** menyimpan buku atau eksemplar yang dipinjam dalam transaksi tersebut. Pemisahan ini diperlukan karena satu transaksi dapat berisi lebih dari satu buku.

#### Denda

Data **Denda** dipisahkan dari transaksi peminjaman karena tidak semua transaksi memiliki denda. Denda hanya dibuat ketika terdapat keterlambatan dan harus dapat diketahui status pembayarannya.

#### Usulan Buku

Data **Usulan Buku** dibuat sebagai entitas tersendiri karena data tersebut berasal dari masukan mahasiswa dan mempunyai status proses sendiri sebelum menjadi bagian dari koleksi perpustakaan.

---

## 5. Aturan Bisnis

| Kode | Aturan Bisnis | Asal |
|---|---|---|
| AB-01 | Mahasiswa harus terdaftar sebagai anggota sebelum melakukan peminjaman buku. | Proses layanan |
| AB-02 | Setiap anggota memiliki satu nomor anggota yang unik. | Identifikasi anggota |
| AB-03 | NIM mahasiswa tidak boleh sama pada dua anggota aktif. | Identifikasi mahasiswa |
| AB-04 | Hanya anggota dengan status `aktif` yang dapat melakukan peminjaman. | Status anggota |
| AB-05 | Maksimal buku yang dapat dipinjam dalam satu transaksi adalah 4 buku. | Parameter P |
| AB-06 | Buku hanya dapat dipinjam jika eksemplar memiliki status `tersedia`. | Status eksemplar |
| AB-07 | Eksemplar dengan kondisi `rusak berat` tidak boleh dipinjam. | Kondisi eksemplar |
| AB-08 | Satu eksemplar tidak boleh tercatat dalam dua peminjaman aktif pada waktu yang sama. | Integritas transaksi |
| AB-09 | Setiap transaksi peminjaman harus mencatat anggota dan petugas yang menangani. | Ketertelusuran |
| AB-10 | Setiap peminjaman memiliki tanggal jatuh tempo. | Aturan peminjaman |
| AB-11 | Tanggal pengembalian diisi ketika buku telah dikembalikan. | Proses pengembalian |
| AB-12 | Ketika buku dikembalikan, status eksemplar harus diperbarui. | Konsistensi data |
| AB-13 | Buku yang terlambat dikembalikan dikenakan denda sebesar Rp2.000 per hari per buku. | Parameter P |
| AB-14 | Tarif denda dicatat pada transaksi agar nilai transaksi lama tidak berubah. | Riwayat transaksi |
| AB-15 | Nilai denda dihitung berdasarkan tarif denda dan jumlah hari keterlambatan. | Perhitungan denda |
| AB-16 | Pembayaran denda harus mengubah status denda menjadi `lunas`. | Pembayaran denda |
| AB-17 | Denda yang belum dibayar tetap dicatat dalam sistem. | Ketertelusuran |
| AB-18 | Setiap usulan buku harus memiliki anggota pengusul. | Proses usulan |
| AB-19 | Setiap kode buku harus unik. | Identifikasi buku |
| AB-20 | Setiap kode eksemplar harus unik. | Identifikasi eksemplar |
| AB-21 | Riwayat peminjaman tidak boleh dihapus hanya karena transaksi telah selesai. | Retensi data |
| AB-22 | Setiap transaksi yang ditangani petugas harus mencatat identitas petugas. | Ketertelusuran |
| AB-23 | Usulan buku harus memiliki status untuk menunjukkan prosesnya. | Pengelolaan usulan |
| AB-24 | Data anggota, buku, dan transaksi harus dapat digunakan untuk membuat laporan. | Kebutuhan informasi |

### Nilai/Domain Data

#### Nilai `status_anggota`

- `aktif`
- `nonaktif`

#### Nilai `kondisi_eksemplar`

- `baik`
- `rusak ringan`
- `rusak berat`

#### Nilai `status_eksemplar`

- `tersedia`
- `dipinjam`
- `tidak tersedia`

#### Nilai `status_peminjaman`

- `aktif`
- `selesai`

#### Nilai `status_denda`

- `belum lunas`
- `lunas`

#### Nilai `status_usulan`

- `diajukan`
- `diproses`
- `diterima`
- `ditolak`

### Catatan Aturan Khusus

Status eksemplar harus selalu mengikuti kondisi transaksi. Ketika buku dipinjam, statusnya menjadi `dipinjam`. Ketika buku sudah dikembalikan dan masih layak digunakan, status dapat diubah kembali menjadi `tersedia`.

Tarif denda disimpan pada transaksi denda karena tarif yang digunakan harus tetap dapat diketahui meskipun aturan denda berubah di kemudian hari.

---

## 6. Kebutuhan Informasi

| Kode | Kebutuhan Informasi | Data yang Diperlukan |
|---|---|---|
| KI-01 | Daftar buku yang sedang dipinjam saat ini | Peminjaman, detail peminjaman, eksemplar, buku |
| KI-02 | Daftar buku yang sudah dikembalikan | Peminjaman, detail peminjaman, eksemplar, buku |
| KI-03 | Daftar peminjaman yang melewati jatuh tempo | Peminjaman, detail peminjaman, anggota, buku |
| KI-04 | Riwayat peminjaman setiap anggota | Anggota, peminjaman, detail, buku |
| KI-05 | Daftar anggota yang mempunyai denda belum lunas | Anggota, denda, detail peminjaman |
| KI-06 | Total denda yang diterima dalam periode tertentu | Denda, peminjaman, anggota |
| KI-07 | Sepuluh buku yang paling sering dipinjam | Buku, eksemplar, detail peminjaman |
| KI-08 | Jumlah peminjaman dan pengembalian per periode | Peminjaman, detail peminjaman |
| KI-09 | Daftar buku berdasarkan kategori | Buku |
| KI-10 | Daftar eksemplar yang rusak | Eksemplar, buku |
| KI-11 | Daftar buku yang tidak tersedia | Eksemplar, buku |
| KI-12 | Daftar usulan buku dari mahasiswa | Anggota, usulan buku |
| KI-13 | Daftar usulan buku yang diterima atau ditolak | Anggota, usulan buku |
| KI-14 | Aktivitas peminjaman berdasarkan petugas | Petugas, peminjaman |
| KI-15 | Laporan kegiatan perpustakaan per bulan | Anggota, buku, petugas, peminjaman, detail, denda, usulan |

---

## 7. Matriks CRUD

| Proses | Anggota | Buku | Eksemplar | Petugas | Peminjaman | Detail | Denda | Usulan Buku |
|---|---|---|---|---|---|---|---|---|
| PB-01 Mendaftarkan anggota | C | | | R | | | | |
| PB-02 Memperbarui data anggota | R/U | | | R | | | | |
| PB-03 Mengelola data buku | | C/R/U | R | R | | | | |
| PB-04 Mengelola data eksemplar | | R | C/R/U | R | | | | |
| PB-05 Mencatat peminjaman buku | R | R | R/U | R | C | C | R | |
| PB-06 Mencatat pengembalian buku | | | R/U | R | R/U | R/U | R/C | |
| PB-07 Mencatat denda keterlambatan | R | | R | R | R | R | C | |
| PB-08 Menerima pembayaran denda | R | | | R | R | R | R/U | |
| PB-09 Mencatat usulan buku | R | R | | R | | | | C |
| PB-10 Memproses usulan buku | R | C | | R/U | | | | R/U |
| PB-11 Mengecek riwayat peminjaman | R | R | R | R | R | R | R | |
| PB-12 Menyusun laporan perpustakaan | R | R | R | R | R | R | R | R |

### Keterangan CRUD

- **C = Create**
- **R = Read**
- **U = Update**
- **D = Delete**

---

## 8. Kamus Data Awal

### 8.1 Entitas Anggota

| Entitas | Elemen | Arti | Contoh | Aturan | Penanggung Jawab |
|---|---|---|---|---|---|
| Anggota | id_anggota | Identitas unik anggota | 1 | Primary key dan unik | Petugas |
| Anggota | no_anggota | Nomor anggota perpustakaan | A-001 | Harus unik | Petugas |
| Anggota | nim_mahasiswa | NIM mahasiswa | 25430001 | Harus unik untuk anggota aktif | Petugas |
| Anggota | nama_anggota | Nama lengkap mahasiswa | Aditya Rizaldiansyah | Wajib diisi | Petugas |
| Anggota | alamat_anggota | Alamat mahasiswa | Metro | Wajib diisi | Petugas |
| Anggota | no_hp_anggota | Nomor HP mahasiswa | 081234567890 | Format nomor valid | Petugas |
| Anggota | tanggal_daftar | Tanggal menjadi anggota | 2026-10-07 | Tanggal valid | Petugas |
| Anggota | status_anggota | Status keanggotaan | aktif | `aktif` atau `nonaktif` | Petugas |

### 8.2 Entitas Buku

| Entitas | Elemen | Arti | Contoh | Aturan | Penanggung Jawab |
|---|---|---|---|---|---|
| Buku | id_buku | Identitas unik buku | 1 | Primary key dan unik | Petugas |
| Buku | kode_buku | Kode identifikasi buku | BK-001 | Harus unik | Petugas |
| Buku | judul_buku | Judul buku | Basis Data | Wajib diisi | Petugas |
| Buku | pengarang_buku | Nama pengarang | Abdul Karim | Wajib diisi | Petugas |
| Buku | penerbit_buku | Nama penerbit | Informatika Press | Wajib diisi | Petugas |
| Buku | tahun_terbit | Tahun diterbitkan | 2025 | Tahun valid | Petugas |
| Buku | kategori_buku | Kategori buku | Buku Kuliah | Wajib diisi | Petugas |

### 8.3 Entitas Eksemplar

| Entitas | Elemen | Arti | Contoh | Aturan | Penanggung Jawab |
|---|---|---|---|---|---|
| Eksemplar | id_eksemplar | Identitas unik buku fisik | 1 | Primary key dan unik | Petugas |
| Eksemplar | kode_eksemplar | Kode buku fisik | EX-001 | Harus unik | Petugas |
| Eksemplar | id_buku | Referensi ke buku | 1 | Foreign key ke Buku | Petugas |
| Eksemplar | kondisi_eksemplar | Kondisi fisik buku | baik | Mengikuti domain kondisi | Petugas |
| Eksemplar | status_eksemplar | Status ketersediaan buku | tersedia | Mengikuti domain status | Petugas |
| Eksemplar | tanggal_masuk | Tanggal buku masuk | 2026-01-10 | Tanggal valid | Petugas |
| Eksemplar | asal_perolehan | Sumber buku | Pembelian | Diisi sesuai sumber | Petugas |

### 8.4 Entitas Petugas

| Entitas | Elemen | Arti | Contoh | Aturan | Penanggung Jawab |
|---|---|---|---|---|---|
| Petugas | id_petugas | Identitas unik petugas | 1 | Primary key dan unik | Kepala |
| Petugas | kode_petugas | Kode petugas | PTG-001 | Harus unik | Kepala |
| Petugas | nama_petugas | Nama petugas | Budi | Wajib diisi | Kepala |
| Petugas | no_hp_petugas | Nomor HP petugas | 081234567890 | Nomor valid | Kepala |
| Petugas | status_petugas | Status petugas | aktif | `aktif` atau `nonaktif` | Kepala |

### 8.5 Entitas Peminjaman

| Entitas | Elemen | Arti | Contoh | Aturan | Penanggung Jawab |
|---|---|---|---|---|---|
| Peminjaman | id_peminjaman | Identitas transaksi | 1 | Primary key dan unik | Petugas |
| Peminjaman | no_peminjaman | Nomor transaksi | PMJ-001 | Harus unik | Petugas |
| Peminjaman | tanggal_jam_peminjaman | Waktu transaksi | 2026-10-07 10:30 | Harus mencatat waktu transaksi | Petugas |
| Peminjaman | id_anggota | Anggota yang meminjam | 1 | Foreign key ke Anggota | Petugas |
| Peminjaman | id_petugas | Petugas yang menangani | 1 | Foreign key ke Petugas | Petugas |
| Peminjaman | status_peminjaman | Status transaksi | aktif | `aktif` atau `selesai` | Petugas |

### 8.6 Entitas Detail Peminjaman

| Entitas | Elemen | Arti | Contoh | Aturan | Penanggung Jawab |
|---|---|---|---|---|---|
| Detail Peminjaman | id_detail_peminjaman | Identitas detail transaksi | 1 | Primary key dan unik | Petugas |
| Detail Peminjaman | id_peminjaman | Referensi transaksi | 1 | Foreign key ke Peminjaman | Petugas |
| Detail Peminjaman | id_eksemplar | Buku fisik yang dipinjam | 1 | Foreign key ke Eksemplar | Petugas |
| Detail Peminjaman | tanggal_jatuh_tempo | Batas pengembalian | 2026-10-14 | Harus valid | Petugas |
| Detail Peminjaman | tanggal_kembali | Tanggal buku dikembalikan | 2026-10-13 | Diisi saat pengembalian | Petugas |
| Detail Peminjaman | jumlah_perpanjangan | Jumlah perpanjangan | 0 | Tidak boleh melebihi aturan | Petugas |

### 8.7 Entitas Denda

| Entitas | Elemen | Arti | Contoh | Aturan | Penanggung Jawab |
|---|---|---|---|---|---|
| Denda | id_denda | Identitas unik denda | 1 | Primary key dan unik | Petugas |
| Denda | id_detail_peminjaman | Detail yang terkena denda | 1 | Foreign key ke Detail | Petugas |
| Denda | tarif_denda | Tarif denda per hari | 2000 | Mengikuti parameter P | Petugas |
| Denda | hari_terlambat | Jumlah hari keterlambatan | 3 | Tidak boleh negatif | Petugas |
| Denda | jumlah_denda | Total denda | 6000 | Tarif × hari terlambat | Petugas |
| Denda | status_denda | Status pembayaran | belum lunas | `belum lunas` atau `lunas` | Petugas |
| Denda | tanggal_bayar_denda | Tanggal pembayaran | 2026-10-16 | Diisi ketika dibayar | Petugas |
| Denda | id_petugas | Petugas yang menerima pembayaran | 1 | Foreign key ke Petugas | Petugas |

### 8.8 Entitas Usulan Buku

| Entitas | Elemen | Arti | Contoh | Aturan | Penanggung Jawab |
|---|---|---|---|---|---|
| Usulan Buku | id_usulan | Identitas unik usulan | 1 | Primary key dan unik | Petugas |
| Usulan Buku | id_anggota | Mahasiswa yang mengusulkan | 1 | Foreign key ke Anggota | Petugas |
| Usulan Buku | judul_usulan | Judul buku yang diusulkan | Pemrograman Python | Wajib diisi | Petugas |
| Usulan Buku | pengarang_usulan | Nama pengarang | Budi | Diisi jika diketahui | Petugas |
| Usulan Buku | alasan_usulan | Alasan pengajuan buku | Untuk mata kuliah | Dapat diisi | Petugas |
| Usulan Buku | tanggal_usulan | Tanggal pengajuan | 2026-10-07 | Tanggal valid | Petugas |
| Usulan Buku | status_usulan | Status usulan | diajukan | Mengikuti domain status | Petugas |

---

## 9. Kebutuhan Non-Fungsional Data

### 9.1 Perhitungan Parameter P

Dua digit terakhir NIM adalah **01**.

~~~text
P = (01 mod 9) + 1
P = 1 + 1
P = 2
~~~

Jadi nilai parameter **P = 2**.

Parameter P digunakan untuk menentukan beberapa kebutuhan proyek:

- Maksimal buku dalam satu transaksi = `P + 2`
- Denda keterlambatan per hari per buku = `P ribu`
- Perkiraan transaksi per hari = `40 + 5P`

Hasil perhitungan:

~~~text
Maksimal buku dalam satu transaksi
= 2 + 2
= 4 buku

Denda keterlambatan per hari per buku
= 2 ribu
= Rp2.000

Perkiraan transaksi per hari
= 40 + (5 × 2)
= 50 transaksi per hari
~~~

### 9.2 Volume Data

Nexus Pustaka AR memiliki data yang terus bertambah dari kegiatan perpustakaan setiap hari.

Perkiraan volume data:

- Jumlah anggota = `[isi jumlah]`
- Jumlah judul buku = `[isi jumlah]`
- Jumlah eksemplar buku = `[isi jumlah]`
- Jumlah petugas = `[isi jumlah]`
- Perkiraan transaksi per hari = **50 transaksi**
- Perkiraan transaksi per bulan = `50 × 30 = 1.500 transaksi`
- Perkiraan transaksi per tahun = `50 × 365 = 18.250 transaksi`

Jumlah tersebut merupakan perkiraan berdasarkan aktivitas transaksi harian dan dapat berubah sesuai kondisi sebenarnya.

### 9.3 Retensi Data

Data perpustakaan perlu disimpan dalam jangka panjang agar riwayat transaksi masih dapat ditelusuri ketika dibutuhkan.

Data yang dipertahankan antara lain:

- Data anggota
- Data buku
- Data eksemplar
- Data petugas
- Data peminjaman
- Data pengembalian
- Data denda
- Data pembayaran denda
- Data usulan buku

Data transaksi yang sudah selesai tidak langsung dihapus karena masih dapat digunakan untuk melihat riwayat anggota dan membuat laporan.

### 9.4 Privasi Data

Beberapa data anggota merupakan data pribadi sehingga perlu dibatasi penggunaannya.

Data yang perlu dilindungi antara lain:

- Nama anggota
- NIM mahasiswa
- Alamat
- Nomor HP
- Riwayat peminjaman

Hak akses secara umum:

| Data | Mahasiswa | Petugas | Kepala Perpustakaan |
|---|---|---|---|
| Data sendiri | R | R/U | R |
| Data anggota lain | Tidak | R/U | R |
| Data buku | R | R/C/U | R |
| Data transaksi | Data sendiri | R/C/U | R |
| Data denda | Data sendiri | R/C/U | R |
| Data usulan | Milik sendiri | R/C/U | R |
| Laporan | Tidak | R | R |

Keterangan:

- **R = Read**
- **C = Create**
- **U = Update**

---

## 10. Isu Kualitas Data yang Diantisipasi

### 10.1 Status Eksemplar Tidak Sesuai dengan Kondisi Sebenarnya (Konsistensi)

Jika status eksemplar tidak diperbarui ketika buku dipinjam atau dikembalikan, sistem dapat menunjukkan data yang tidak sesuai dengan kondisi sebenarnya. Misalnya buku sebenarnya sudah dikembalikan tetapi di database masih berstatus `dipinjam`.

### 10.2 Data Pengembalian Tidak Dicatat (Kelengkapan)

Jika tanggal pengembalian tidak diisi setelah buku dikembalikan, sistem akan tetap menganggap peminjaman masih berlangsung. Hal ini dapat memengaruhi data keterlambatan dan status buku.

### 10.3 Data Anggota Terdaftar Lebih dari Satu Kali (Keunikan)

Mahasiswa dapat tercatat lebih dari satu kali apabila nomor anggota atau NIM tidak diperiksa dengan baik. Masalah ini dapat menyebabkan riwayat anggota menjadi terpisah.

### 10.4 Data Buku Tidak Lengkap (Kelengkapan)

Data buku seperti judul, pengarang, penerbit, atau kategori harus diisi dengan lengkap. Data yang tidak lengkap dapat menyulitkan pencarian dan pembuatan laporan buku.

### 10.5 Jumlah Denda Tidak Sesuai (Akurasi)

Jumlah denda harus sesuai dengan tarif yang berlaku dan jumlah hari keterlambatan. Kesalahan perhitungan dapat menyebabkan denda yang dibayarkan tidak sesuai.

### 10.6 Tarif Denda Lama Berubah karena Mengikuti Tarif Baru (Ketertelusuran)

Jika sistem hanya menyimpan tarif denda yang berlaku saat ini dan tidak menyimpan tarif pada transaksi lama, maka riwayat denda sebelumnya dapat menjadi tidak jelas. Oleh karena itu, tarif denda perlu dicatat pada transaksi denda.

### 10.7 Kondisi Buku Tidak Diperbarui (Kemutakhiran)

Buku yang sering digunakan dapat mengalami perubahan kondisi. Jika kondisi eksemplar tidak diperbarui, sistem dapat menganggap buku masih dalam kondisi baik padahal keadaan sebenarnya berbeda.

### 10.8 Riwayat Peminjaman Tidak Lengkap (Ketertelusuran)

Setiap transaksi harus dicatat dengan benar agar riwayat peminjaman anggota dapat dicari kembali. Data yang hilang akan menyulitkan petugas saat memeriksa transaksi lama.

### 10.9 Identitas Petugas Tidak Dicatat (Ketertelusuran)

Setiap transaksi peminjaman, pengembalian, dan pembayaran denda harus memiliki informasi petugas yang menanganinya agar transaksi dapat ditelusuri ketika terjadi masalah.

### 10.10 Status Usulan Buku Tidak Diperbarui (Kemutakhiran)

Usulan buku dapat berubah dari `diajukan` menjadi `diproses`, `diterima`, atau `ditolak`. Jika status tidak diperbarui, petugas akan kesulitan mengetahui perkembangan usulan tersebut.

---

## 11. Ringkasan Entitas

Entitas yang digunakan dalam Nexus Pustaka AR adalah:

1. **Anggota**
2. **Buku**
3. **Eksemplar**
4. **Petugas**
5. **Peminjaman**
6. **Detail Peminjaman**
7. **Denda**
8. **Usulan Buku**

---

## 12. Ringkasan Hubungan Antar Entitas

Secara umum hubungan antarentitas adalah sebagai berikut:

- Satu **Anggota** dapat memiliki banyak **Peminjaman**.
- Satu **Petugas** dapat menangani banyak **Peminjaman**.
- Satu **Peminjaman** dapat memiliki banyak **Detail Peminjaman**.
- Satu **Eksemplar** dapat muncul dalam banyak transaksi sepanjang waktu, tetapi tidak boleh dipinjam oleh lebih dari satu anggota pada waktu yang sama.
- Satu **Buku** dapat memiliki banyak **Eksemplar**.
- Satu **Detail Peminjaman** dapat memiliki satu **Denda** jika terjadi keterlambatan.
- Satu **Anggota** dapat membuat banyak **Usulan Buku**.
- Satu **Petugas** dapat memproses banyak **Usulan Buku**.

---

# Urutan Inti Dokumen

---

## Alur Dokumen

```text
┌─────────────────────────────────────────────┐
│              IDENTITAS PROYEK               │
└──────────────────────┬──────────────────────┘
                       │
                       ▼
┌─────────────────────────────────────────────┐
│ 1. LATAR BELAKANG & AKTIVITAS ORGANISASI    │
└──────────────────────┬──────────────────────┘
                       │
                       ▼
┌─────────────────────────────────────────────┐
│ 2. AKTOR & PROSES BISNIS                    │
└──────────────────────┬──────────────────────┘
                       │
                       ▼
┌─────────────────────────────────────────────┐
│ 3. DOKUMEN SUMBER YANG DIANALISIS           │
└──────────────────────┬──────────────────────┘
                       │
                       ▼
┌─────────────────────────────────────────────┐
│ 4. ENTITAS KANDIDAT & ELEMEN DATA           │
└──────────────────────┬──────────────────────┘
                       │
                       ▼
┌─────────────────────────────────────────────┐
│ 5. ATURAN BISNIS                             │
└──────────────────────┬──────────────────────┘
                       │
                       ▼
┌─────────────────────────────────────────────┐
│ 6. KEBUTUHAN INFORMASI                       │
└──────────────────────┬──────────────────────┘
                       │
                       ▼
┌─────────────────────────────────────────────┐
│ 7. MATRIKS CRUD                              │
└──────────────────────┬──────────────────────┘
                       │
                       ▼
┌─────────────────────────────────────────────┐
│ 8. KAMUS DATA AWAL                           │
└──────────────────────┬──────────────────────┘
                       │
                       ▼
┌─────────────────────────────────────────────┐
│ 9. KEBUTUHAN NON-FUNGSIONAL DATA             │
└──────────────────────┬──────────────────────┘
                       │
                       ▼
┌─────────────────────────────────────────────┐
│ 10. ISU KUALITAS DATA                        │
└─────────────────────────────────────────────┘