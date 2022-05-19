-- DATABASE PINJAM_BUKU
CREATE DATABASE pinjam_buku;

-- Tabel SISWA
CREATE TABLE siswa (
	id_siswa int PRIMARY KEY,
	nama_siswa varchar(20),
	email varchar(30)
);

-- Tabel BUKU
CREATE TABLE buku (
	id_buku int PRIMARY KEY,
	nama_buku varchar(20),
	penerbit varchar(30)
);

-- Tabel PINJAM
CREATE TABLE pinjam (
    id_pinjam int PRIMARY KEY,
	id_siswa int
	id_buku int,
	tanggal_pinjam date
);

-- INSERT tabel SISWA
INSERT INTO siswa
(id_siswa, nama_siswa, email)
VALUES('121', 'A', 'a@gmail.com');

INSERT INTO siswa
(id_siswa, nama_siswa, email)
VALUES('122', 'B', 'b@gmail.com');

INSERT INTO siswa
(id_siswa, nama_siswa, email)
VALUES('123', 'C', 'c@gmail.com');

INSERT INTO siswa
(id_siswa, nama_siswa, email)
VALUES('124', 'D', 'd@gmail.com');

-- INSERT tabel BUKU
INSERT INTO buku
(id_buku, nama_buku, penerbit)
VALUES('111', 'Jaringan Komputer', 'Dunia Komputer');

INSERT INTO buku
(id_buku, nama_buku, penerbit)
VALUES('222', 'Software Hacking', 'Elex Media');

INSERT INTO buku
(id_buku, nama_buku, penerbit)
VALUES('333', 'Kriptografi', 'Andi');

-- INSERT tabel PINJAM
INSERT INTO pinjam
(id_pinjam, id_siswa, id_buku, tanggal_pinjam)
VALUES('001', '121', '333', '2022-01-19');

INSERT INTO pinjam
(id_pinjam, id_siswa, id_buku, tanggal_pinjam)
VALUES('002', '122', '111', '2022-02-12');

INSERT INTO pinjam
(id_pinjam, id_siswa, id_buku, tanggal_pinjam)
VALUES('003', '123', '222', '2022-02-04');

INSERT INTO pinjam
(id_pinjam, id_siswa, id_buku, tanggal_pinjam)
VALUES('004', '121', '111', '2022-03-10');

INSERT INTO pinjam
(id_pinjam, id_siswa, id_buku, tanggal_pinjam)
VALUES('005', '123', '333', '2022-02-28');

-- Tampilkan semua isi data tabel pada database PERPUSTAKAAN
select*from siswa;
select*from buku;
select*from pinjam;

-- Tampilkan data tabel dengan JOIN
SELECT siswa.id_siswa, nama_siswa as nama, email FROM siswa JOIN pinjam ON siswa.id_siswa = pinjam.id_siswa;
SELECT buku.id_buku, nama_buku as judul, penerbit FROM buku JOIN pinjam ON buku.id_buku = pinjam.id_buku;
SELECT id_pinjam, pinjam.id_siswa, pinjam.id_buku, tanggal_pinjam FROM pinjam JOIN siswa ON siswa.id_siswa = pinjam.id_siswa;
-- atau :
SELECT id_pinjam, pinjam.id_siswa, pinjam.id_buku, tanggal_pinjam FROM pinjam JOIN buku ON buku.id_buku = pinjam.id_buku;
