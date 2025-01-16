-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 01, 2025 at 10:53 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `gubuk_sastra`
--

-- --------------------------------------------------------

--
-- Table structure for table `buku`
--

CREATE TABLE `buku` (
  `kode_buku` varchar(255) NOT NULL,
  `judul_buku` varchar(255) NOT NULL,
  `pengarang` varchar(255) NOT NULL,
  `penerbit` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `buku`
--

INSERT INTO `buku` (`kode_buku`, `judul_buku`, `pengarang`, `penerbit`) VALUES
('buku_1', 'Grit', 'Angela Duckworth', 'Gramedia'),
('buku_2', 'To Kill a Mockingbird', 'Harper Lee', 'J.B. Lippincott & Co.'),
('buku_3', '1984', 'George Orwell', 'Secker & Warburg'),
('buku_4', 'Pride and Prejudice', 'Jane Austen', 'T. Egerton'),
('buku_5', 'Moby-Dick', 'Herman Melville', 'Picasso'),
('buku_6', 'One Hundred Years', 'Gabriel Garcia', 'Gramedia'),
('buku_7', 'sa', 'as', 'qw');

-- --------------------------------------------------------

--
-- Table structure for table `peminjaman`
--

CREATE TABLE `peminjaman` (
  `no_pinjaman` varchar(200) NOT NULL,
  `id_anggota` varchar(255) NOT NULL,
  `id_buku` varchar(255) NOT NULL,
  `judul_buku` varchar(255) NOT NULL,
  `tgl_pinjam` varchar(255) NOT NULL,
  `tgl_kembali` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `peminjaman`
--

INSERT INTO `peminjaman` (`no_pinjaman`, `id_anggota`, `id_buku`, `judul_buku`, `tgl_pinjam`, `tgl_kembali`) VALUES
('noPinjam_1', 'giant-1', 'buku_1', 'Grit', '1 Januari 2025', '1 Januari 2025'),
('noPinjam_2', 'kenji-99', 'buku_3', '1984', '12 Juli 2025', '14 Juli 2025'),
('noPinjam_4', 'giant-1', 'buku_5', 'Moby-Dick', '2 Agustus 2025', '4 Agustus 2025');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(99) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `nama_lengkap` varchar(100) NOT NULL,
  `jenis_kelamin` varchar(100) NOT NULL,
  `alamat` varchar(100) NOT NULL,
  `role` enum('admin','user') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `nama_lengkap`, `jenis_kelamin`, `alamat`, `role`) VALUES
(5, 'Giant', '$2a$10$ewQn/N2Fz8YTuVd5Vdn19.4mFu.pM7lvYpwzTuNB1Vm61VDNcSuUi', 'Giant Prakoso', 'Laki-laki', 'Klaten, Jawa Tengah', 'user'),
(8, 'admin1', '$2a$10$o6MuGtphAAIhG89JnH521eJpmYM1GVHqQj59/ze6l0RrBPpxmM/S2', 'Veronica', 'Perempuan', 'Surakarta', 'admin'),
(9, 'kenji', '$2a$10$4tLnyP/H7fV1ogV8T8fppuTAMtDiK5sOZpjRIpZO1tGeFdrHXPv0e', 'Kenji Sugiharto', 'Laki-laki', 'Klaten, Jawa Tengah', 'user'),
(10, 'ipam', '$2a$10$n54HFLCTQYYzDr539fx7fuy003HgpgGUyoVxCEaxo.gaMOe1EMhEm', 'Ipam NurFakhrudin', 'Laki-laki', 'Boyolali', 'user'),
(11, 'Asep', '$2a$10$7BI1m3p6UeMBuvqpC3rOkesEYk0.HbY7PzDM5kkcW7nDcNIxoTLj6', 'Asep Setiawan', 'Laki-laki', 'Surabaya', 'user'),
(12, 'Monica', '$2a$10$vxgIrNnGxZNIdMdCu99GdOj3JtlBsEacsDrbFy/5dhmpF7VXCkwjC', 'Monica Julia', 'Perempuan', 'Semarang', 'user'),
(13, 'caroline', '$2a$10$laBtWpLHNk0x0U9QT9T6oesPFc7FTwy0.Ti9NrC2B6A.hdEPXxyVW', 'Caroline Riyadi', 'Perempuan', 'Ambarawa', 'user'),
(14, 'kepalaPerpus', '$2a$10$WAB.imiEIBBQsXjCgXdWV.15hXLqkA/LEmm3dtiJFKLIO0ezzmRWu', 'Ocean Kirana', 'Perempuan', 'Wonogiri', 'admin'),
(15, 'admin2', '$2a$10$5hT5UCNbKcxYczfR7wPn5O6IWfDUeCBWvLTza5X2bEjeHSjASYpRW', 'Budi', 'Laki-laki', 'Boyolali', 'admin'),
(16, 'user2', '$2a$10$gY.l4WroVJxWBgLRwL6KaeKLx2nWnq4CWiAzOixwTDnaznvL033g2', 'Kiwil', 'Laki-laki', 'Kebumen', 'user');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `buku`
--
ALTER TABLE `buku`
  ADD PRIMARY KEY (`kode_buku`);

--
-- Indexes for table `peminjaman`
--
ALTER TABLE `peminjaman`
  ADD PRIMARY KEY (`no_pinjaman`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(99) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
