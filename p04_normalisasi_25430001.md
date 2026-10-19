# Normalisasi Proyek Nexus Pustaka AR - Pertemuan 4

**Nama:** Aditya Rizaldiansyah
**NIM:** 25430001
**Tema:** Perpustakaan (`perpus`)
**Sumber:** `p02_kebutuhan_data_25430001.md` dan ERD `p03_erd_25430001.drawio`

## 1. Dokumen Sumber

Dokumen sumber yang dipakai adalah **Slip Peminjaman** (bagian 3.3 dokumen kebutuhan data), karena satu slip memuat beberapa buku sehingga memiliki grup berulang.

**Penyesuaian rancangan slip:** slip pada Pertemuan 2 hanya mencantumkan Kode Buku (kode judul). Padahal yang dipinjam adalah buku fisik (eksemplar), dan aturan bisnis AB-06, AB-07, dan AB-08 berlaku untuk eksemplar. Karena itu setiap baris slip ditambah **Kode Eksemplar**.

```text
==================================================
              NEXUS PUSTAKA AR
              SLIP PEMINJAMAN
==================================================
No. Peminjaman : PMJ-001
Tanggal        : 07-10-2026 10:30
No. Anggota    : A-001
Nama Anggota   : [Nama Mahasiswa]
Kode Petugas   : PTG-001
Petugas        : [Nama Petugas]
--------------------------------------------------
| No | Kode Eksemplar | Kode Buku | Judul Buku                |
|----|----------------|-----------|---------------------------|
| 1  | EX-001         | BK-001    | Basis Data                |
| 2  | EX-014         | BK-005    | Algoritma dan Pemrograman |
--------------------------------------------------
Jumlah Buku    : 2
Jatuh Tempo    : 14-10-2026
Status         : Dipinjam
Denda          : Rp [Nominal]
==================================================
```

Kolom "No" pada tabel slip hanya nomor urut tampilan, sehingga tidak dimasukkan sebagai atribut.

## 2. Bentuk UNF

Satu baris mewakili satu slip peminjaman. Buku-buku yang dipinjam adalah grup berulang (ditandai `{ }`).

```text
PEMINJAMAN_UNF (no_peminjaman, tanggal_jam_peminjaman, no_anggota, nama_anggota,
  kode_petugas, nama_petugas,
  { kode_eksemplar, kode_buku, judul_buku },
  jumlah_buku, tanggal_jatuh_tempo, status_peminjaman, total_denda)
```

Nama atribut mengikuti pola `<atribut>_<nama_tabel>` (Tabel P.3) sesuai keputusan desain Pertemuan 3.

## 3. Bentuk 1NF

Grup berulang dihilangkan: satu baris untuk setiap eksemplar di setiap slip peminjaman. Kunci primer menjadi komposit **(no_peminjaman, kode_eksemplar)**, karena satu slip memuat beberapa eksemplar dan satu eksemplar dapat dipinjam berkali-kali pada slip berbeda.

```text
PEMINJAMAN_1NF (no_peminjaman, kode_eksemplar, tanggal_jam_peminjaman, no_anggota, nama_anggota,
  kode_petugas, nama_petugas, kode_buku, judul_buku,
  jumlah_buku, tanggal_jatuh_tempo, status_peminjaman, total_denda)
```

Contoh data 1NF (fiktif):

| no_peminjaman | kode_eksemplar | tanggal_jam_peminjaman | no_anggota | nama_anggota | kode_petugas | nama_petugas | kode_buku | judul_buku |
|---|---|---|---|---|---|---|---|---|
| PMJ-001 | EX-001 | 2026-10-07 10:30 | A-001 | Rina | PTG-001 | Budi | BK-001 | Basis Data |
| PMJ-001 | EX-014 | 2026-10-07 10:30 | A-001 | Rina | PTG-001 | Budi | BK-005 | Algoritma dan Pemrograman |
| PMJ-002 | EX-001 | 2026-10-20 09:15 | A-007 | Dodi | PTG-001 | Budi | BK-001 | Basis Data |

Masalah yang masih tersisa di 1NF: data slip (tanggal, anggota, petugas) dan data buku (judul) tertulis berulang di banyak baris. Contohnya, nama petugas "Budi" muncul di setiap baris dan judul "Basis Data" muncul setiap kali eksemplar EX-001 dipinjam. Pengulangan ini menimbulkan anomali ubah, sisip, dan hapus.

## 4. Dependensi Fungsional

Dependensi fungsional diturunkan dari aturan bisnis pada dokumen kebutuhan data Pertemuan 2, bukan dari isi contoh data.

| Kode | Dependensi fungsional | Arti | Dasar |
|---|---|---|---|
| FD1 | no_peminjaman → tanggal_jam_peminjaman, no_anggota, kode_petugas, tanggal_jatuh_tempo, status_peminjaman | Satu slip memiliki satu waktu peminjaman, satu anggota, satu petugas, satu tanggal jatuh tempo, dan satu status | AB-09, AB-10 |
| FD2 | no_anggota → nama_anggota | Satu nomor anggota hanya milik satu anggota | AB-02 |
| FD3 | kode_petugas → nama_petugas | Satu kode petugas hanya milik satu petugas | AB-22; kamus data (kode_petugas unik) |
| FD4 | kode_eksemplar → kode_buku | Satu eksemplar adalah salinan dari tepat satu judul buku | AB-20, AB-25 |
| FD5 | kode_buku → judul_buku | Satu kode buku hanya menunjuk satu judul | AB-19 |
| FD6 | no_peminjaman → jumlah_buku | Jumlah eksemplar dalam satu slip (turunan, dihitung dari baris detail) | AB-05 |
| FD7 | no_peminjaman → total_denda | Jumlah seluruh denda buku dalam satu slip (turunan) | AB-13, AB-15 |

```text
FD1: no_peminjaman -> tanggal_jam_peminjaman, no_anggota, kode_petugas,
                      tanggal_jatuh_tempo, status_peminjaman          (AB-09, AB-10)
FD2: no_anggota -> nama_anggota                                       (AB-02)
FD3: kode_petugas -> nama_petugas                                     (AB-22)
FD4: kode_eksemplar -> kode_buku                                      (AB-20, AB-25)
FD5: kode_buku -> judul_buku                                          (AB-19)
FD6: no_peminjaman -> jumlah_buku                                     (turunan, AB-05)
FD7: no_peminjaman -> total_denda                                     (turunan, AB-13, AB-15)
```

**Keputusan jatuh tempo:** AB-10 menyatakan setiap peminjaman memiliki tanggal jatuh tempo, dan slip mencantumkan jatuh tempo satu kali. Karena itu tanggal_jatuh_tempo bergantung pada no_peminjaman (FD1), bukan pada pasangan (no_peminjaman, kode_eksemplar). Akibatnya atribut ini dipindah dari detail_peminjaman ke peminjaman, dan ERD Pertemuan 3 diperbarui (lihat bagian Perubahan ERD).

**Catatan:** pada slip, kunci (no_peminjaman, kode_eksemplar) tidak menentukan atribut lain. Atribut per eksemplar yang dipinjam, yaitu tanggal_kembali_detail_peminjaman, berasal dari Bukti Pengembalian dan ditambahkan pada skema final.

## 5. Bentuk 2NF

Kunci 1NF adalah komposit (no_peminjaman, kode_eksemplar). Atribut yang hanya bergantung pada sebagian kunci (ketergantungan parsial):

- Bergantung pada **no_peminjaman** saja (FD1, FD2, FD3, FD6, FD7): tanggal_jam_peminjaman, no_anggota, nama_anggota, kode_petugas, nama_petugas, tanggal_jatuh_tempo, status_peminjaman, jumlah_buku, total_denda.
- Bergantung pada **kode_eksemplar** saja (FD4, FD5): kode_buku, judul_buku.

Atribut tersebut dipindah ke relasi tersendiri:

```text
PEMINJAMAN_2NF (no_peminjaman, tanggal_jam_peminjaman, no_anggota, nama_anggota,
                kode_petugas, nama_petugas, tanggal_jatuh_tempo, status_peminjaman,
                jumlah_buku, total_denda)

EKSEMPLAR_2NF (kode_eksemplar, kode_buku, judul_buku)

DETAIL_PEMINJAMAN_2NF (no_peminjaman*, kode_eksemplar*)
```

Keterangan: kolom pertama setiap relasi adalah kunci primer (DETAIL_PEMINJAMAN memakai kunci komposit dua kolom); tanda * = kunci tamu.

DETAIL_PEMINJAMAN_2NF hanya berisi kunci karena slip peminjaman tidak memuat atribut lain per eksemplar. Relasi ini tetap diperlukan untuk mencatat eksemplar mana yang dipinjam pada slip mana (hubungan banyak-ke-banyak antara peminjaman dan eksemplar).

Anomali sisip berkurang: eksemplar baru kini dapat dicatat di EKSEMPLAR_2NF tanpa menunggu ada peminjaman. Namun PEMINJAMAN_2NF masih menyimpan nama anggota dan nama petugas secara berulang, dan EKSEMPLAR_2NF masih menyimpan judul buku berulang untuk setiap salinan.

## 6. Bentuk 3NF

Hasil 2NF masih memiliki ketergantungan transitif (atribut bukan kunci ditentukan oleh atribut bukan kunci lain):

- no_peminjaman → no_anggota → nama_anggota (FD1, FD2)
- no_peminjaman → kode_petugas → nama_petugas (FD1, FD3)
- kode_eksemplar → kode_buku → judul_buku (FD4, FD5)

Rantai tersebut diputus dengan memindahkan anggota, petugas, dan buku ke relasi sendiri:

```text
PEMINJAMAN_3NF (no_peminjaman, tanggal_jam_peminjaman, no_anggota*, kode_petugas*,
                tanggal_jatuh_tempo, status_peminjaman, jumlah_buku, total_denda)

ANGGOTA_3NF (no_anggota, nama_anggota)

PETUGAS_3NF (kode_petugas, nama_petugas)

EKSEMPLAR_3NF (kode_eksemplar, kode_buku*)

BUKU_3NF (kode_buku, judul_buku)

DETAIL_PEMINJAMAN_3NF (no_peminjaman*, kode_eksemplar*)
```

Keterangan: kolom pertama setiap relasi adalah kunci primer (DETAIL_PEMINJAMAN memakai kunci komposit dua kolom); tanda * = kunci tamu.

Catatan: jumlah_buku dan total_denda adalah nilai turunan (FD6, FD7). Keputusan menyimpan atau menghitungnya dibahas pada bagian berikutnya.

### Ringkasan tahapan

| Tahap | Relasi | Yang dihilangkan |
|---|---|---|
| UNF | PEMINJAMAN_UNF | — (masih ada grup berulang eksemplar) |
| 1NF | PEMINJAMAN_1NF | Grup berulang eksemplar per slip |
| 2NF | PEMINJAMAN, EKSEMPLAR, DETAIL_PEMINJAMAN | Ketergantungan parsial (FD1, FD4) |
| 3NF | PEMINJAMAN, ANGGOTA, PETUGAS, EKSEMPLAR, BUKU, DETAIL_PEMINJAMAN | Ketergantungan transitif (FD2, FD3, FD5) |

## 7. Keputusan Nilai Turunan

| Nilai turunan | Rumus | Keputusan | Alasan |
|---|---|---|---|
| jumlah_buku | jumlah baris DETAIL_PEMINJAMAN per no_peminjaman | Dihitung | Selalu sesuai jumlah eksemplar yang benar-benar tercatat; batas maksimal 4 buku (AB-05) diperiksa dari jumlah baris detail |
| hari_terlambat_denda | tanggal_kembali_detail_peminjaman − tanggal_jatuh_tempo_peminjaman | Dihitung | Dapat dihitung dari dua tanggal yang sudah disimpan; jika disimpan bisa tidak cocok saat tanggal kembali diralat |
| jumlah_denda | tarif_denda × hari_terlambat_denda | Dihitung | Tarif sudah dikunci per transaksi (AB-14), sehingga hasil hitungan selalu sama dengan nilai saat denda terjadi (AB-15) |
| total_denda | Σ jumlah_denda dalam satu peminjaman | Dihitung | Jika disimpan, bisa berbeda dengan denda per buku saat salah satu denda diralat |

**Nilai asal yang tetap disimpan:** tarif_denda (AB-14), tanggal_jatuh_tempo_peminjaman (AB-10), tanggal_kembali_detail_peminjaman (AB-11), dan status_denda (AB-16).

**Perubahan dari Pertemuan 2:** kamus data awal mencatat jumlah_denda sebagai "dihitung dan disimpan". Setelah normalisasi, jumlah_denda diputuskan untuk dihitung, karena tarif_denda yang disimpan sudah cukup untuk menjaga nilai historis denda. Prinsip ini sama dengan harga saat transaksi pada Kopma (AB-04): nilai asal dikunci, nilai turunannya dihitung.

## 8. Skema 3NF Final

Hasil 3NF dilengkapi dengan atribut dari kamus data (Pertemuan 2) yang tidak tercatat di slip peminjaman, serta relasi denda dan usulan_buku dari ERD Pertemuan 3. Nilai turunan tidak disimpan (bagian 7).

```text
ANGGOTA (no_anggota, nim_anggota, nama_anggota, alamat_anggota, no_hp_anggota,
         tanggal_daftar_anggota, status_anggota)
PETUGAS (kode_petugas, nama_petugas, no_hp_petugas, status_petugas)
BUKU (kode_buku, judul_buku, pengarang_buku, penerbit_buku, tahun_terbit_buku, kategori_buku)
EKSEMPLAR (kode_eksemplar, kode_buku*, kondisi_eksemplar, status_eksemplar,
           tanggal_masuk_eksemplar, asal_perolehan_eksemplar)
PEMINJAMAN (no_peminjaman, tanggal_jam_peminjaman, no_anggota*, kode_petugas*,
            tanggal_jatuh_tempo_peminjaman, status_peminjaman)
DETAIL_PEMINJAMAN (no_peminjaman*, kode_eksemplar*, tanggal_kembali_detail_peminjaman)
DENDA (no_peminjaman*, kode_eksemplar*, tarif_denda, status_denda, tanggal_bayar_denda, kode_petugas*)
USULAN_BUKU (id_usulan_buku, no_anggota*, judul_usulan_buku, pengarang_usulan_buku,
             alasan_usulan_buku, tanggal_usulan_buku, status_usulan_buku)
-- kolom pertama = kunci primer (DETAIL_PEMINJAMAN dan DENDA: dua kolom pertama); * = kunci tamu
```

Catatan:

- DENDA memakai kunci yang sama dengan DETAIL_PEMINJAMAN karena satu buku dalam satu peminjaman paling banyak memiliki satu denda (AB-13, AB-17).
- kode_petugas pada DENDA boleh kosong karena denda yang belum lunas belum memiliki petugas penerima (AB-16, AB-17).
- USULAN_BUKU tidak memiliki kode alami di kamus data, sehingga tetap memakai id_usulan_buku.

## 9. Skema dengan Kunci Pengganti

Sesuai ERD Pertemuan 3, setiap tabel memakai kunci pengganti `id_*` sebagai kunci primer, sedangkan kode alami menjadi kunci unik.

| Tabel | Kunci primer | Kunci unik | Kunci tamu |
|---|---|---|---|
| anggota | id_anggota | no_anggota, nim_anggota | – |
| petugas | id_petugas | kode_petugas | – |
| buku | id_buku | kode_buku | – |
| eksemplar | id_eksemplar | kode_eksemplar | id_buku |
| peminjaman | id_peminjaman | no_peminjaman | id_anggota, id_petugas |
| detail_peminjaman | id_detail_peminjaman | (id_peminjaman, id_eksemplar) | id_peminjaman, id_eksemplar |
| denda | id_denda | id_detail_peminjaman | id_detail_peminjaman, id_petugas (boleh NULL) |
| usulan_buku | id_usulan_buku | – | id_anggota |

Dua kunci unik baru yang ditemukan dari normalisasi dan belum tercantum di ERD Pertemuan 3:

- **(id_peminjaman, id_eksemplar) pada detail_peminjaman**: mencegah eksemplar yang sama tercatat dua kali dalam satu peminjaman.
- **id_detail_peminjaman pada denda**: menjamin satu detail paling banyak memiliki satu denda (kardinalitas 0..1).

Keduanya akan diwujudkan sebagai constraint UNIQUE pada Pertemuan 5.

## 10. Pemeriksaan BCNF

### Temuan pada tabel anggota

AB-03 semula berbunyi: *"NIM mahasiswa tidak boleh sama pada dua anggota aktif."* Artinya, NIM yang sama dapat muncul di dua baris (satu aktif, satu nonaktif), sehingga nim_anggota bukan kunci kandidat. Padahal satu NIM selalu menunjuk satu mahasiswa, sehingga berlaku:

```text
nim_anggota -> nama_anggota, alamat_anggota, no_hp_anggota
```

Penentu nim_anggota bukan kunci kandidat, sehingga tabel anggota **tidak memenuhi BCNF** (juga terdapat rantai transitif id_anggota → nim_anggota → nama_anggota). Contoh anomali yang dapat terjadi:

| no_anggota | nim_anggota | nama_anggota | status_anggota |
|---|---|---|---|
| A-001 | 25430099 | Rina | nonaktif |
| A-150 | 25430099 | Rina Putri | aktif |

**Perbaikan:** AB-03 direvisi menjadi *"NIM mahasiswa unik untuk setiap anggota. Mahasiswa yang berhenti lalu kembali aktif cukup diubah status keanggotaannya, bukan didaftarkan ulang."* Dengan revisi ini nim_anggota menjadi kunci kandidat, sesuai ERD Pertemuan 3 yang sudah menandai nim_anggota sebagai kunci alternatif (AK).

### Hasil pemeriksaan seluruh tabel (setelah perbaikan)

| Tabel | Penentu (sisi kiri FD) | Kunci kandidat? | BCNF |
|---|---|---|---|
| anggota | id_anggota, no_anggota, nim_anggota | Ya, ketiganya unik (AB-02, AB-03 revisi) | ✅ |
| petugas | id_petugas, kode_petugas | Ya, keduanya unik | ✅ |
| buku | id_buku, kode_buku | Ya, keduanya unik (AB-19) | ✅ |
| eksemplar | id_eksemplar, kode_eksemplar | Ya, keduanya unik (AB-20) | ✅ |
| peminjaman | id_peminjaman, no_peminjaman | Ya, keduanya unik | ✅ |
| detail_peminjaman | id_detail_peminjaman, (id_peminjaman, id_eksemplar) | Ya, keduanya unik | ✅ |
| denda | id_denda, id_detail_peminjaman | Ya, keduanya unik (satu detail paling banyak satu denda) | ✅ |
| usulan_buku | id_usulan_buku | Ya | ✅ |

Kesimpulan: setelah AB-03 direvisi, tidak ada penentu yang bukan kunci kandidat, sehingga seluruh tabel proyek memenuhi BCNF. Pemeriksaan dilakukan dengan kunci alami, bukan hanya kunci pengganti, karena kunci pengganti tidak menghapus dependensi fungsional (Troubleshooting Masalah 3).

## Perubahan ERD dan Aturan Bisnis

| No | Perubahan | Alasan | Dampak |
|----|-----------|--------|--------|
| 1 | `tanggal_jatuh_tempo_detail_peminjaman` dipindah dari `detail_peminjaman` ke `peminjaman` menjadi `tanggal_jatuh_tempo_peminjaman` | AB-10: satu peminjaman memiliki satu tanggal jatuh tempo (FD1: no_peminjaman → tanggal_jatuh_tempo) | ERD `p03_erd_25430001.drawio` dan KI-03 diperbarui |
| 2 | AB-03 direvisi: NIM unik untuk setiap anggota | Pemeriksaan BCNF: `nim_anggota` harus menjadi kunci kandidat | Dokumen `p02_kebutuhan_data_25430001.md` diperbarui |
| 3 | Kunci unik baru: (`id_peminjaman`, `id_eksemplar`) pada `detail_peminjaman` dan `id_detail_peminjaman` pada `denda` | Mencegah eksemplar yang sama tercatat dua kali dalam satu peminjaman dan mencegah satu detail memiliki dua denda | Dicatat di sini, diterapkan sebagai `UNIQUE` pada Modul 5 |