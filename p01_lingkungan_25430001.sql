-- p01_lingkungan_25430001.sql
-- Skrip ini aman dijalankan berulang kali.
-- Password sengaja diganti penanda. JANGAN commit password asli.
CREATE DATABASE IF NOT EXISTS kopma_001
  CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER IF NOT EXISTS 'mhs_001'@'localhost' IDENTIFIED BY '<password_kerja>';
GRANT ALL PRIVILEGES ON kopma_001.* TO 'mhs_001'@'localhost';

-- Milestone Proyek 1
CREATE DATABASE IF NOT EXISTS perpus_001
  CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER IF NOT EXISTS 'dev_001'@'localhost' IDENTIFIED BY '<password_dev>';
GRANT ALL PRIVILEGES ON perpus_001.* TO 'dev_001'@'localhost';
