# Normalisasi Kopma - Pertemuan 4

**Nama:** Aditya Rizaldiansyah
**NIM:** 25430001

## 1. Bentuk UNF (spreadsheet lama)

Satu baris mewakili satu nota. Barang-barang di dalam nota adalah grup berulang (ditandai `{ }`).

```text
NOTA_UNF (no_nota_penjualan, tgl_penjualan, kode_petugas, nama_petugas, no_anggota, nama_anggota,
  { kode_barang, nama_barang, qty_detail_penjualan, harga_satuan_detail_penjualan, subtotal_detail_penjualan },
  jumlah_penjualan, diskon_penjualan, total_penjualan)
```
## 2. Bentuk 1NF

Grup berulang dihilangkan: satu baris untuk setiap barang di setiap nota, sehingga setiap sel hanya berisi satu nilai. Kunci primer menjadi komposit **(no_nota_penjualan, kode_barang)** karena nomor nota saja tidak lagi unik.

```text
NOTA_1NF (no_nota_penjualan, kode_barang, tgl_penjualan, kode_petugas, nama_petugas, no_anggota,
  nama_anggota, nama_barang, qty_detail_penjualan, harga_satuan_detail_penjualan,
  subtotal_detail_penjualan, jumlah_penjualan, diskon_penjualan, total_penjualan)
```

Contoh data 1NF (fiktif):

| no_nota_penjualan | kode_barang | tgl_penjualan | nama_petugas | nama_anggota | nama_barang | qty_detail_penjualan | harga_satuan_detail_penjualan |
|---|---|---|---|---|---|---|---|
| PJ-2609-0142 | BRG-01 | 2026-09-14 | Budi | Sari | Pulpen | 2 | 4000 |
| PJ-2609-0142 | BRG-02 | 2026-09-14 | Budi | Sari | Buku tulis | 1 | 6000 |
| PJ-2609-0150 | BRG-01 | 2026-09-15 | Budi | Sari | Pulpen | 3 | 4000 |

Masalah yang masih tersisa di 1NF: tanggal, nama petugas, nama anggota, dan nama barang tertulis berulang di banyak baris. Pengulangan ini menimbulkan anomali yang akan dihilangkan pada tahap 2NF dan 3NF.

## 3. Dependensi Fungsional

Dependensi fungsional diturunkan dari aturan bisnis Kopma (Pertemuan 2), bukan dari isi spreadsheet.

| Kode | Dependensi fungsional | Arti | Dasar |
|---|---|---|---|
| FD1 | no_nota_penjualan → tgl_penjualan, kode_petugas, no_anggota | Satu nota punya satu tanggal, satu kasir, dan paling banyak satu anggota | AB-01, AB-02 |
| FD2 | kode_petugas → nama_petugas | Satu kode petugas hanya milik satu orang | Wawancara (data petugas) |
| FD3 | no_anggota → nama_anggota | Satu nomor anggota hanya milik satu anggota | AB-05 |
| FD4 | kode_barang → nama_barang | Satu kode barang hanya menunjuk satu barang | Kode alami barang |
| FD5 | (no_nota_penjualan, kode_barang) → qty_detail_penjualan, harga_satuan_detail_penjualan | Jumlah dan harga ditentukan oleh pasangan nota dan barang | AB-04 |
| FD6 | qty_detail_penjualan, harga_satuan_detail_penjualan → subtotal_detail_penjualan | Subtotal = qty × harga (nilai turunan) | Perhitungan |

```text
FD1: no_nota_penjualan -> tgl_penjualan, kode_petugas, no_anggota       (AB-01)
FD2: kode_petugas -> nama_petugas
FD3: no_anggota -> nama_anggota                                         (AB-05)
FD4: kode_barang -> nama_barang
FD5: (no_nota_penjualan, kode_barang) -> qty_detail_penjualan,
     harga_satuan_detail_penjualan                                      (AB-04)
FD6: qty_detail_penjualan, harga_satuan_detail_penjualan
     -> subtotal_detail_penjualan                                       (turunan)
```

## Titik Analisis 1

**Pertanyaan:** Mengapa FD5 menempatkan harga_satuan_detail_penjualan pada kunci (no_nota_penjualan, kode_barang), bukan pada kode_barang saja? Apa yang terjadi pada laporan omzet tahun lalu jika harga_satuan_detail_penjualan dipindah ke tabel barang?

**Jawaban:** Harga di nota tidak ditentukan oleh kode barang saja. Barang yang sama dapat terjual dengan harga berbeda pada nota yang berbeda, misalnya pulpen BRG-01 terjual Rp4.000 pada September dan Rp4.500 pada Oktober setelah harga naik. Satu kode barang menghasilkan lebih dari satu harga, sehingga kode_barang → harga_satuan_detail_penjualan bukan dependensi fungsional. Harga baru pasti tunggal jika nota dan barangnya diketahui, sehingga harga bergantung pada kunci (no_nota_penjualan, kode_barang), sesuai AB-04.

Jika harga dipindah ke tabel barang, hanya satu harga yang tersimpan, yaitu harga terbaru. Saat harga pulpen dinaikkan dari Rp4.000 menjadi Rp4.500, harga lama tertimpa. Laporan omzet tahun lalu yang dihitung ulang akan memakai Rp4.500, sehingga nilainya membengkak dan tidak sesuai dengan uang yang benar-benar diterima saat itu. Data historis menjadi salah.

## 4. Bentuk 2NF

Kunci 1NF adalah komposit (no_nota_penjualan, kode_barang). Beberapa atribut hanya bergantung pada sebagian kunci (ketergantungan parsial):

- FD1: tgl_penjualan, kode_petugas, no_anggota hanya bergantung pada **no_nota_penjualan**.
- FD4: nama_barang hanya bergantung pada **kode_barang**.

Atribut yang bergantung parsial dipindah ke relasi tersendiri:

```text
PENJUALAN_2NF (no_nota_penjualan, tgl_penjualan, kode_petugas, nama_petugas,
               no_anggota, nama_anggota, jumlah_penjualan, diskon_penjualan, total_penjualan)

BARANG_2NF (kode_barang, nama_barang)

DETAIL_PENJUALAN_2NF (no_nota_penjualan*, kode_barang*, qty_detail_penjualan,
                      harga_satuan_detail_penjualan, subtotal_detail_penjualan)
```

Keterangan: kolom pertama setiap relasi adalah kunci primer; tanda * = kunci tamu.

Setelah 2NF, tidak ada lagi atribut yang bergantung pada sebagian kunci komposit. Namun PENJUALAN_2NF masih menyimpan nama_petugas dan nama_anggota yang tertulis berulang di setiap nota.

## 5. Bentuk 3NF

PENJUALAN_2NF masih memiliki ketergantungan transitif (atribut bukan kunci yang ditentukan oleh atribut bukan kunci lain):

- no_nota_penjualan → kode_petugas → nama_petugas (FD1, FD2)
- no_nota_penjualan → no_anggota → nama_anggota (FD1, FD3)

Rantai tersebut diputus dengan memindahkan petugas dan anggota ke relasi sendiri. PENJUALAN hanya menyimpan kode_petugas dan no_anggota sebagai kunci tamu.

```text
PENJUALAN_3NF (no_nota_penjualan, tgl_penjualan, kode_petugas*, no_anggota*,
               jumlah_penjualan, diskon_penjualan, total_penjualan)

PETUGAS_3NF (kode_petugas, nama_petugas)

ANGGOTA_3NF (no_anggota, nama_anggota)

BARANG_3NF (kode_barang, nama_barang)

DETAIL_PENJUALAN_3NF (no_nota_penjualan*, kode_barang*, qty_detail_penjualan,
                      harga_satuan_detail_penjualan, subtotal_detail_penjualan)
```

Keterangan: kolom pertama setiap relasi adalah kunci primer (DETAIL_PENJUALAN memakai kunci komposit dua kolom pertama); tanda * = kunci tamu.

Catatan: jumlah_penjualan, diskon_penjualan, total_penjualan, dan subtotal_detail_penjualan adalah nilai turunan (FD6). Keputusan menyimpan atau menghitungnya dibahas pada bagian berikutnya.

### Ringkasan tahapan

| Tahap | Relasi | Yang dihilangkan |
|---|---|---|
| UNF | NOTA_UNF | — (masih ada grup berulang) |
| 1NF | NOTA_1NF | Grup berulang barang |
| 2NF | PENJUALAN, BARANG, DETAIL_PENJUALAN | Ketergantungan parsial (FD1, FD4) |
| 3NF | PENJUALAN, PETUGAS, ANGGOTA, BARANG, DETAIL_PENJUALAN | Ketergantungan transitif (FD2, FD3) |

## 6. Keputusan Nilai Turunan

| Nilai turunan | Rumus | Keputusan | Alasan |
|---|---|---|---|
| subtotal_detail_penjualan | qty_detail_penjualan × harga_satuan_detail_penjualan | Dihitung | Dapat dihitung dari detail; jika disimpan bisa tidak cocok saat qty atau harga diralat |
| jumlah_penjualan | Σ subtotal dalam satu nota | Dihitung | Bergantung pada seluruh baris detail nota |
| diskon_penjualan | 5% × jumlah jika anggota aktif (AB-02) | Dihitung | Ditentukan dari jumlah dan status anggota |
| total_penjualan | jumlah − diskon | Dihitung | Turunan dari dua nilai turunan lain |
| kembalian | bayar_penjualan − total | Dihitung | Turunan dari bayar dan total |

**Keputusan:** semua nilai turunan tidak disimpan di tabel operasional, sehingga tidak mungkin tidak konsisten dengan rinciannya. Yang disimpan adalah data asal: qty, harga saat transaksi (AB-04), status anggota, dan uang yang dibayar (bayar_penjualan).

## 7. Skema 3NF Final

Hasil 3NF dilengkapi dengan atribut dari kamus data dan entitas kandidat Kopma (Tabel 2.3) yang tidak tercatat di spreadsheet lama.

```text
PENJUALAN (no_nota_penjualan, tgl_penjualan, kode_petugas*, no_anggota*, bayar_penjualan)
DETAIL_PENJUALAN (no_nota_penjualan*, kode_barang*, qty_detail_penjualan, harga_satuan_detail_penjualan)
BARANG (kode_barang, nama_barang, kategori_barang, harga_jual_barang, stok_barang, stok_min_barang)
PETUGAS (kode_petugas, nama_petugas, peran_petugas)
ANGGOTA (no_anggota, nim_anggota, nama_anggota, prodi_anggota, no_hp_anggota, status_anggota, tgl_daftar_anggota)
-- kolom pertama = kunci primer (DETAIL_PENJUALAN: dua kolom pertama), * = kunci tamu
```

Catatan: no_anggota pada PENJUALAN boleh kosong karena penjualan boleh tanpa anggota (AB-02). Kolom bayar_penjualan tidak ada di UNF buku, tetapi berasal dari nota penjualan (Gambar 2.5) dan merupakan data asal yang tidak dapat dihitung.

## Titik Analisis 2

**Pertanyaan:** Keputusan "total tidak disimpan" akan ditinjau ulang di Buku 2 Modul 2, ketika tabel arsip penjualan justru menyimpan total. Mengapa keputusan yang berbeda itu tetap konsisten?

**Jawaban:** Pada tabel operasional, total tidak disimpan karena dapat dihitung dari qty dan harga pada detail penjualan. Data operasional masih dapat berubah, misalnya qty diralat, sehingga total yang disimpan berisiko tidak cocok dengan rinciannya. Sebaliknya, tabel arsip berisi transaksi yang sudah final dan dijadikan riwayat, sehingga datanya tidak akan diubah lagi dan tidak ada risiko total menjadi tidak cocok. Menyimpan total di arsip justru mengunci potret nilai transaksi saat itu agar tidak ikut berubah jika aturan (misalnya persentase diskon) berubah di kemudian hari. Kedua keputusan konsisten karena prinsipnya sama: nilai yang dapat berubah dihitung, sedangkan potret historis yang tidak boleh berubah disimpan.

## 8. Skema Kanonik Kopma (Tabel 4.2)

Kunci primer diganti dengan kunci pengganti `id_*`; kode alami menjadi kunci unik. Tabel pemasok, pembelian, dan detail_pembelian ditambahkan dari ERD Pertemuan 3, karena tidak tercatat di spreadsheet penjualan lama.

| Tabel | Kunci primer | Kunci unik | Kunci tamu |
|---|---|---|---|
| petugas | id_petugas | kode_petugas | – |
| anggota | id_anggota | no_anggota, nim_anggota | – |
| barang | id_barang | kode_barang | – |
| pemasok | id_pemasok | kode_pemasok | – |
| penjualan | id_penjualan | no_nota_penjualan | id_petugas, id_anggota (boleh NULL) |
| detail_penjualan | (id_penjualan, id_barang) | – | id_penjualan, id_barang |
| pembelian | id_pembelian | – | id_pemasok |
| detail_pembelian | (id_pembelian, id_barang) | – | id_pembelian, id_barang |

Perbedaan dengan hasil normalisasi saya hanya pada penggunaan kunci pengganti; susunan tabel dan atribut sama. Catatan: Tabel 4.2 buku tidak mencantumkan kunci unik untuk pemasok, sedangkan ERD Pertemuan 3 saya memakai kode_pemasok sebagai kunci alternatif (dari Tabel 2.3).

## 9. Pemeriksaan BCNF

| Tabel | Penentu (sisi kiri FD) | Kunci kandidat? | BCNF |
|---|---|---|---|
| petugas | id_petugas, kode_petugas | Ya, keduanya unik | ✅ |
| anggota | id_anggota, no_anggota, nim_anggota | Ya, ketiganya unik (AB-05) | ✅ |
| barang | id_barang, kode_barang | Ya, keduanya unik | ✅ |
| pemasok | id_pemasok, kode_pemasok | Ya, keduanya unik | ✅ |
| penjualan | id_penjualan, no_nota_penjualan | Ya, keduanya unik (AB-01) | ✅ |
| detail_penjualan | (id_penjualan, id_barang) | Ya, kunci komposit | ✅ |
| pembelian | id_pembelian | Ya | ✅ |
| detail_pembelian | (id_pembelian, id_barang) | Ya, kunci komposit | ✅ |

Kesimpulan: tidak ada penentu yang bukan kunci kandidat, sehingga seluruh tabel Kopma memenuhi BCNF. Kunci pengganti tidak dianggap menyelesaikan normalisasi; pemeriksaan tetap dilakukan dengan kunci alami (Troubleshooting Masalah 3).

## Titik Analisis 3

**Pertanyaan:** Kolom pemasok_brg di spreadsheet lama tidak muncul di tabel barang. Di mana informasi "barang ini dipasok oleh siapa" kini disimpan? Apa keuntungannya dibanding menyimpan satu nama pemasok di tabel barang?

**Jawaban:** Informasi tersebut diperoleh dari riwayat pembelian melalui jalur barang → detail_pembelian → pembelian → pemasok. Detail pembelian mencatat barang yang dibeli, sedangkan pembelian mencatat pemasok yang menerbitkan faktur. Keuntungannya: (1) satu barang dapat dipasok oleh lebih dari satu pemasok, sedangkan satu kolom pemasok_brg hanya dapat menampung satu nama; (2) Kopma dapat berganti pemasok tanpa mengubah data barang, dan riwayat pembelian lama tetap menunjukkan pemasok yang benar; (3) nama pemasok hanya ditulis sekali di tabel pemasok, sehingga masalah ejaan nama pemasok yang berubah-ubah pada spreadsheet lama tidak terulang.