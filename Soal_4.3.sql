-- 1.	Buatlah sebuah transaction dengan skenario-skenario statement sebagai berikut:
-- ●	Mulai transaction
-- ●	Insert data produk sebanyak 3 record
-- ●	Update data stok salah satu produk
-- ●	Buat savepoint
-- ●	Hapus salah satu data pembayaran
-- ●	Kembali ke savepoint
-- ●	Update data iuran salah satu kartu
-- ●	Akhiri transaction dengan commit


START TRANSACTION ;

INSERT INTO produk (kode, nama, harga_beli, harga_jual, stok, min_stok, foto, deskripsi, jenis_produk_id)
VALUES ('P001', 'Produk 1', 10000, 15000, 10, 5, 'foto1.jpg', 'Deskripsi Produk 1', 1),
       ('P002', 'Produk 2', 12000, 18000, 8, 5, 'foto2.jpg', 'Deskripsi Produk 2', 1),
       ('P003', 'Produk 3', 15000, 20000, 5, 5, 'foto3.jpg', 'Deskripsi Produk 3', 1);
-- +----+------+----------+------------+------------+------+----------+-----------+--------------------+-----------------+
-- | id | kode | nama     | harga_beli | harga_jual | stok | min_stok | foto      | deskripsi          | jenis_produk_id |
-- +----+------+----------+------------+------------+------+----------+-----------+--------------------+-----------------+
-- | 41 | P001 | Produk 1 |      10000 |      15000 |   10 |        5 | foto1.jpg | Deskripsi Produk 1 |               1 |
-- | 42 | P002 | Produk 2 |      12000 |      18000 |    8 |        5 | foto2.jpg | Deskripsi Produk 2 |               1 |
-- | 43 | P003 | Produk 3 |      15000 |      20000 |    5 |        5 | foto3.jpg | Deskripsi Produk 3 |               1 |
-- +----+------+----------+------------+------------+------+----------+-----------+--------------------+-----------------+



UPDATE produk
SET stok = 15
WHERE kode = 'P001';
-- | id | kode | nama     | harga_beli | harga_jual | stok | min_stok | foto      | deskripsi          | jenis_produk_id |
-- +----+------+----------+------------+------------+------+----------+-----------+--------------------+-----------------+
-- | 41 | P001 | Produk 1 |      10000 |      15000 |   15 |        5 | foto1.jpg | Deskripsi Produk 1 |               1 |
-- +----+------+----------+------------+------------+------+----------+-----------+--------------------+-----------------+



SAVEPOINT before_delete;


DELETE FROM pembayaran WHERE id = 5;
-- +----+------------+------------+--------+------+------------+-------------------+
-- | id | nokuitansi | tanggal    | jumlah | ke   | pesanan_id | status_pembayaran |
-- +----+------------+------------+--------+------+------------+-------------------+
-- |  1 | MD001      | 0000-00-00 |  30000 |    1 |         11 | Lunas             |
-- |  2 | MD002      | 2023-10-10 |  30000 |    2 |         11 | Lunas             |
-- |  3 | MD003      | 2023-10-10 |  30000 |    1 |         11 | Lunas             |
-- |  4 | MD004      | 2023-10-10 |  15000 |    1 |          2 |                   |
-- +----+------------+------------+--------+------+------------+-------------------+

ROLLBACK TO before_delete;

-- +----+------------+------------+--------+------+------------+-------------------+
-- | id | nokuitansi | tanggal    | jumlah | ke   | pesanan_id | status_pembayaran |
-- +----+------------+------------+--------+------+------------+-------------------+
-- |  1 | MD001      | 0000-00-00 |  30000 |    1 |         11 | Lunas             |
-- |  2 | MD002      | 2023-10-10 |  30000 |    2 |         11 | Lunas             |
-- |  3 | MD003      | 2023-10-10 |  30000 |    1 |         11 | Lunas             |
-- |  4 | MD004      | 2023-10-10 |  15000 |    1 |          2 |                   |
-- |  5 | MD005      | 2023-10-10 |  18000 |    2 |          2 | Lunas             |
-- +----+------------+------------+--------+------+------------+-------------------+

UPDATE kartu
SET iuran = 100000 
WHERE kode = 'SLV';
-- +----+------+---------------+--------+--------+
-- | id | kode | nama          | diskon | iuran  |
-- +----+------+---------------+--------+--------+
-- |  1 | GOLD | Gold Utama    |   0.05 | 100000 |
-- |  2 | PLAT | Platinum Jaya |    0.1 | 150000 |
-- |  3 | SLV  | Silver        |  0.025 | 100000 |
-- |  4 | NO   | Non Member    |      0 |      0 |
-- |  7 | PGU  | Perunggu      |    0.5 |   2000 |
-- +----+------+---------------+--------+--------+

COMMIT;

-- Penggunaan LOCK TABLES READ:

-- LOCK TABLES READ digunakan ketika akan mencegah tabel dari operasi tulis yang mengubah data, tetapi masih memungkinkan operasi baca.
-- Ini berguna ketika ingin menghindari perubahan data selama proses pembacaan yang panjang atau penting, tetapi tidak ingin menghalangi operasi baca.

-- LOCK TABLES READ biasanya digunakan dalam skenario di mana akan menjaga konsistensi data selama operasi baca yang panjang, misalnya saat menjalankan laporan yang melibatkan beberapa tabel yang kompleks.