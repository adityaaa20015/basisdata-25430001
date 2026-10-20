-- p05_latihan_kopma_25430001.sql
-- Latihan dan Modifikasi Pertemuan 5 (Kopma)
-- Dijalankan dengan akun mhs_001 setelah p05_ddl_kopma_25430001.sql

USE kopma_001;

-- Latihan 1: stok minimum tidak boleh negatif
ALTER TABLE barang
    ADD CONSTRAINT ck_barang_stok_min CHECK (stok_min_barang >= 0);
    
-- Latihan 2: anggota dihapus -> id_anggota pada penjualan menjadi NULL
ALTER TABLE penjualan DROP FOREIGN KEY fk_penjualan_anggota;
ALTER TABLE penjualan
    ADD CONSTRAINT fk_penjualan_anggota
    FOREIGN KEY (id_anggota) REFERENCES anggota (id_anggota)
    ON DELETE SET NULL;