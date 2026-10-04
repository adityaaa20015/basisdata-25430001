-- p01_lingkungan_25430001.sql
-- Password sengaja diganti penanda. JANGAN commit password asli.
CREATE DATABASE kopma_001
  CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER 'mhs_001'@'localhost' IDENTIFIED BY '<password_kerja>';
GRANT ALL PRIVILEGES ON kopma_001.* TO 'mhs_001'@'localhost';