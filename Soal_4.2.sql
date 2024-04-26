-- 1.
SELECT pesanan.id, pesanan.tanggal, pesanan. total, pelanggan.kode, pelanggan.nama, 
kartu.nama as nama_kartu, kartu.diskon
FROM pesanan INNER JOIN pelanggan ON pesanan.pelanggan_id = pelanggan.id
INNER JOIN kartu ON pelanggan.kartu_id = kartu.id;

-- +----+------------+---------+------+--------------------+---------------+--------+
-- | id | tanggal    | total   | kode | nama               | nama_kartu    | diskon |
-- +----+------------+---------+------+--------------------+---------------+--------+
-- |  1 | 2015-11-04 | 9720000 | C001 | Agung Sedayu Group | Gold Utama    |   0.05 |
-- |  2 | 2015-11-04 |   17500 | C003 | Sekar Mirah        | Gold Utama    |   0.05 |
-- |  3 | 2015-11-04 |       0 | C006 | Gayatri Dwi        | Gold Utama    |   0.05 |
-- |  4 | 2015-11-04 |       0 | C007 | Dewi Gyat          | Gold Utama    |   0.05 |
-- |  5 | 2015-11-04 |       0 | C010 | Cassanndra         | Gold Utama    |   0.05 |
-- |  6 | 2015-11-04 |       0 | C002 | Pandan Wangi       | Platinum Jaya |    0.1 |
-- |  7 | 2015-11-04 |       0 | C005 | Pradabashu         | Platinum Jaya |    0.1 |
-- |  8 | 2015-11-04 |       0 | C004 | Swandaru Geni      | Non Member    |      0 |
-- |  9 | 2015-11-04 |       0 | C008 | Andre Haru         | Non Member    |      0 |
-- | 10 | 2015-11-04 |       0 | C009 | Ahmad Hasan        | Non Member    |      0 |
-- | 11 | 2015-11-04 |   30000 | C009 | Ahmad Hasan        | Non Member    |      0 |
-- +----+------------+---------+------+--------------------+---------------+--------+

-- 2.
SELECT * FROM vendor;
CREATE VIEW pembelian_produk_vendor 
AS SELECT p.id, p.tanggal, p.nomor, p.jumlah, p.harga,
pr.nama, v.nama as nama_vendor, v.kontak FROM pembelian p INNER JOIN produk pr
ON p.produk_id = pr.id 
INNER JOIN vendor v ON p.vendor_id = v.id;
SELECT * FROM pembelian_produk_vendor;


-- +----+------------+-------+--------+---------+-------------------+----------------------+-----------------+
-- | id | tanggal    | nomor | jumlah | harga   | nama              | nama_vendor          | kontak          |
-- +----+------------+-------+--------+---------+-------------------+----------------------+-----------------+
-- |  1 | 2019-10-10 | P001  |      2 | 3500000 | Televisi 21 inchs | PT Guna Samudra      | Ali Nurdin      |
-- |  2 | 2019-11-20 | P002  |      5 | 5500000 | Televisi 40 inch  | PT Pondok C9         | Putri Ramadhani |
-- |  3 | 2019-12-12 | P003  |      5 | 5400000 | Televisi 40 inch  | PT Guna Samudra      | Ali Nurdin      |
-- |  4 | 2020-01-20 | P004  |    200 |    1800 | Teh Botol         | CV Jaya Raya Semesta | Dwi Rahayu      |
-- |  5 | 2020-01-20 | P005  |    100 |    2300 | Teh Kotak         | CV Jaya Raya Semesta | Dwi Rahayu      |
-- +----+------------+-------+--------+---------+-------------------+----------------------+-----------------+