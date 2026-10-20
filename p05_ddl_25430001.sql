-- p05_ddl_25430001.sql
-- DDL basis data proyek Nexus Pustaka AR - Pertemuan 5
-- Nama: Aditya Rizaldiansyah | NIM: 25430001
-- Dijalankan dengan akun dev_001
-- Sumber: skema 3NF p04_normalisasi_25430001.md, ERD revisi Pertemuan 4,
--         aturan bisnis dan domain nilai p02_kebutuhan_data_25430001.md

USE perpus_001;

-- =========================================
-- HAPUS TABEL LAMA (anak dulu, lalu induk)
-- =========================================
DROP TABLE IF EXISTS denda;
DROP TABLE IF EXISTS detail_peminjaman;
DROP TABLE IF EXISTS usulan_buku;
DROP TABLE IF EXISTS peminjaman;
DROP TABLE IF EXISTS eksemplar;
DROP TABLE IF EXISTS buku;
DROP TABLE IF EXISTS anggota;
DROP TABLE IF EXISTS petugas;

-- =========================================
-- TABEL MASTER
-- =========================================

CREATE TABLE petugas (
    id_petugas     SMALLINT     NOT NULL AUTO_INCREMENT,
    kode_petugas   CHAR(7)      NOT NULL,                    -- contoh: PTG-001
    nama_petugas   VARCHAR(100) NOT NULL,
    no_hp_petugas  VARCHAR(15)  NULL,                        -- data pribadi
    status_petugas ENUM('aktif','nonaktif') NOT NULL DEFAULT 'aktif',
    PRIMARY KEY (id_petugas),
    UNIQUE KEY uq_petugas_kode (kode_petugas)               -- kode petugas unik (kunci alami p04)
) ENGINE=InnoDB;

CREATE TABLE anggota (
    id_anggota             INT          NOT NULL AUTO_INCREMENT,
    no_anggota             CHAR(5)      NOT NULL,            -- contoh: A-001
    nim_anggota            CHAR(8)      NOT NULL,            -- contoh: 25430001
    nama_anggota           VARCHAR(100) NOT NULL,
    alamat_anggota         VARCHAR(200) NOT NULL,
    no_hp_anggota          VARCHAR(15)  NULL,                -- data pribadi
    tanggal_daftar_anggota DATE         NOT NULL,
    status_anggota         ENUM('aktif','nonaktif') NOT NULL DEFAULT 'aktif',  -- AB-04
    PRIMARY KEY (id_anggota),
    UNIQUE KEY uq_anggota_no  (no_anggota),                 -- AB-02: nomor anggota unik
    UNIQUE KEY uq_anggota_nim (nim_anggota)                 -- AB-03 (revisi P4): NIM unik
) ENGINE=InnoDB;

CREATE TABLE buku (
    id_buku           INT          NOT NULL AUTO_INCREMENT,
    kode_buku         CHAR(6)      NOT NULL,                 -- contoh: BK-001
    judul_buku        VARCHAR(200) NOT NULL,
    pengarang_buku    VARCHAR(100) NOT NULL,
    penerbit_buku     VARCHAR(100) NOT NULL,
    tahun_terbit_buku YEAR         NOT NULL,
    kategori_buku     VARCHAR(50)  NOT NULL,
    PRIMARY KEY (id_buku),
    UNIQUE KEY uq_buku_kode (kode_buku)                     -- AB-19: kode buku unik
) ENGINE=InnoDB;

CREATE TABLE eksemplar (
    id_eksemplar             INT         NOT NULL AUTO_INCREMENT,
    kode_eksemplar           CHAR(6)     NOT NULL,           -- contoh: EX-001
    id_buku                  INT         NOT NULL,
    kondisi_eksemplar        ENUM('baik','rusak ringan','rusak berat') NOT NULL DEFAULT 'baik',
    status_eksemplar         ENUM('tersedia','dipinjam','tidak tersedia') NOT NULL DEFAULT 'tersedia',  -- AB-06
    tanggal_masuk_eksemplar  DATE        NOT NULL,
    asal_perolehan_eksemplar VARCHAR(50) NOT NULL,
    PRIMARY KEY (id_eksemplar),
    UNIQUE KEY uq_eksemplar_kode (kode_eksemplar),          -- AB-20: kode eksemplar unik
    CONSTRAINT fk_eksemplar_buku FOREIGN KEY (id_buku) REFERENCES buku (id_buku),   -- AB-25
    CONSTRAINT ck_eksemplar_rusak_berat
        CHECK (NOT (kondisi_eksemplar = 'rusak berat' AND status_eksemplar = 'dipinjam'))  -- AB-07
) ENGINE=InnoDB;

-- =========================================
-- TABEL TRANSAKSI
-- =========================================

CREATE TABLE peminjaman (
    id_peminjaman                  INT      NOT NULL AUTO_INCREMENT,
    no_peminjaman                  CHAR(7)  NOT NULL,        -- contoh: PMJ-001
    id_petugas                     SMALLINT NOT NULL,        -- AB-09, AB-22: petugas wajib dicatat
    id_anggota                     INT      NOT NULL,        -- AB-01, AB-09: peminjam wajib anggota
    tanggal_jam_peminjaman         DATETIME NOT NULL,
    tanggal_jatuh_tempo_peminjaman DATE     NOT NULL,        -- AB-10: satu jatuh tempo per peminjaman
    status_peminjaman              ENUM('aktif','selesai') NOT NULL DEFAULT 'aktif',
    PRIMARY KEY (id_peminjaman),
    UNIQUE KEY uq_peminjaman_no (no_peminjaman),
    CONSTRAINT fk_peminjaman_petugas FOREIGN KEY (id_petugas) REFERENCES petugas (id_petugas),
    CONSTRAINT fk_peminjaman_anggota FOREIGN KEY (id_anggota) REFERENCES anggota (id_anggota)
) ENGINE=InnoDB;

CREATE TABLE detail_peminjaman (
    id_detail_peminjaman              INT  NOT NULL AUTO_INCREMENT,
    id_peminjaman                     INT  NOT NULL,
    id_eksemplar                      INT  NOT NULL,
    tanggal_kembali_detail_peminjaman DATE NULL,             -- AB-11: diisi saat buku kembali
    PRIMARY KEY (id_detail_peminjaman),
    UNIQUE KEY uq_detail_peminjaman_eksemplar (id_peminjaman, id_eksemplar),  -- kunci unik p04
    -- tanpa ON DELETE CASCADE: AB-21 riwayat peminjaman tidak boleh dihapus
    CONSTRAINT fk_detail_peminjaman_peminjaman FOREIGN KEY (id_peminjaman) REFERENCES peminjaman (id_peminjaman),
    CONSTRAINT fk_detail_peminjaman_eksemplar  FOREIGN KEY (id_eksemplar)  REFERENCES eksemplar (id_eksemplar)
) ENGINE=InnoDB;

CREATE TABLE denda (
    id_denda             INT           NOT NULL AUTO_INCREMENT,
    id_detail_peminjaman INT           NOT NULL,
    id_petugas           SMALLINT      NULL,                 -- petugas penerima pembayaran
    tarif_denda          DECIMAL(12,2) NOT NULL DEFAULT 2000.00,  -- AB-13 (P = 2), AB-14: tarif disimpan
    status_denda         ENUM('belum lunas','lunas') NOT NULL DEFAULT 'belum lunas',  -- AB-17
    tanggal_bayar_denda  DATE          NULL,
    PRIMARY KEY (id_denda),
    UNIQUE KEY uq_denda_detail (id_detail_peminjaman),      -- kunci unik p04: satu detail satu denda
    CONSTRAINT fk_denda_detail_peminjaman FOREIGN KEY (id_detail_peminjaman) REFERENCES detail_peminjaman (id_detail_peminjaman),
    CONSTRAINT fk_denda_petugas FOREIGN KEY (id_petugas) REFERENCES petugas (id_petugas),
    CONSTRAINT ck_denda_tarif CHECK (tarif_denda >= 0),
    CONSTRAINT ck_denda_lunas CHECK (status_denda <> 'lunas' OR tanggal_bayar_denda IS NOT NULL)  -- AB-16
    -- hari_terlambat_denda dan jumlah_denda tidak disimpan: dihitung (keputusan p04, AB-15)
) ENGINE=InnoDB;

CREATE TABLE usulan_buku (
    id_usulan_buku        INT          NOT NULL AUTO_INCREMENT,
    id_anggota            INT          NOT NULL,             -- AB-18: usulan wajib punya pengusul
    judul_usulan_buku     VARCHAR(200) NOT NULL,
    pengarang_usulan_buku VARCHAR(100) NULL,
    alasan_usulan_buku    VARCHAR(255) NULL,
    tanggal_usulan_buku   DATE         NOT NULL,
    status_usulan_buku    ENUM('diajukan','diproses','diterima','ditolak') NOT NULL DEFAULT 'diajukan',  -- AB-23
    PRIMARY KEY (id_usulan_buku),
    CONSTRAINT fk_usulan_buku_anggota FOREIGN KEY (id_anggota) REFERENCES anggota (id_anggota)
) ENGINE=InnoDB;

-- =========================================
-- ATURAN YANG TIDAK DAPAT DIJAGA CHECK (ditandai untuk Modul 14)
-- =========================================
-- AB-05 : maksimal P + 2 = 4 buku per peminjaman. Menyangkut JUMLAH BARIS
--         detail_peminjaman per peminjaman; CHECK hanya memeriksa satu baris.
-- AB-08 : satu eksemplar tidak boleh ada di dua peminjaman aktif sekaligus
--         (banyak baris dan dua tabel).
-- AB-04 : hanya anggota berstatus aktif yang boleh meminjam (membaca tabel anggota).
-- AB-12 : status eksemplar diperbarui saat buku kembali (proses, bukan isi data).