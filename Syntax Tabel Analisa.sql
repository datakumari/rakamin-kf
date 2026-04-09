--cek tabel utama final_transaction
select *
from `rakamin-kimia-farma-491902.kinerja_kf_20202023.kf_final_transaction`

--cek tabel utama kantor_cabang
SELECT * from `rakamin-kimia-farma-491902.kinerja_kf_20202023.kf_kantor_cabang`

--cek tabel utama inventory
select *
from `rakamin-kimia-farma-491902.kinerja_kf_20202023.kf_inventory`

--cek tabel utama product
select *
from `rakamin-kimia-farma-491902.kinerja_kf_20202023.kf_product`

--join dengan data yang diperlukan
SELECT 
  t.transaction_id,
  t.date,
  t.branch_id,
  c.branch_name,
  c.kota,
  c.provinsi,
  c.rating as rating_cabang
  t.customer_name,
  t.product_id,
  p.product_name,
  t.price as actual_price,
  t.discount_percentage,
  case
    when t.price <=50000 then 0.1
    when t.price >50000 and t.price <=100000 then 0.15
    when t.price >100000 and t.price <=300000 then 0.2
    when t.price >300000 and t.price <=500000 then 0.25
    else 0.3
  end as persentase_gross_laba,
  t.price * (1 - t.discount_percentage) as nett_sales,
  t.rating as rating_transaksi
FROM `kinerja_kf_20202023.kf_final_transaction` t
left join `kinerja_kf_20202023.kf_kantor_cabang` c
on t.branch_id = c.branch_id
left join `rakamin-kimia-farma-491902.kinerja_kf_20202023.kf_product` p
on t.product_id = p.product_id
