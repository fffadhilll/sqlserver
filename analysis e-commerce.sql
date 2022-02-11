use belajar;
exec sp_help orders;
exec sp_belajar orders;

select top 1 * from order_details;
select top 1 * from orders;
select top 1 * from products;
select top 1 * from users;

-- no 1
select * from products;

--get total products
select count(*) from products;

--get total category product
select count(distinct category) from products;
select * from products where category is null;

--no 2
select * from orders;
select count(*) from orders;
select count(*) from orders where paid_at is null;

-- no 3

--get the total transaction at a certain time
select count(*) from orders where FORMAT(created_at, 'yyyy-MM') = '2019-09';
select count(*) from orders where FORMAT(created_at, 'yyyy-MM') = '2019-11';
select count(*) from orders where FORMAT(created_at, 'yyyy-MM') = '2020-01';
select count(*) from orders where FORMAT(created_at, 'yyyy-MM') = '2020-03';
select count(*) from orders where FORMAT(created_at, 'yyyy-MM') = '2020-05';

--no 4
--get transactions that have been paid for but not sent
select count(*) from orders where paid_at is not null and delivery_at = 'NA';

--get transactions that are not sent, whether paid or not
select count(*) from orders where delivery_at = 'NA';

--get transactions sent on the same day as the date paid
select count(*) from orders where LEFT(delivery_at, LEN(delivery_at)) = LEFT(paid_at, LEN(paid_at));

--no 5
--get total users
select count(*) from users;

--get users who have transacted as buyers
select count(DISTINCT u.user_id)
from users u
join orders o 
on u.user_id = o.buyer_id;

--get users who have transacted as buyers
select count(DISTINCT u.user_id)
from users u
join orders o 
on u.user_id = o.seller_id;

--get users who have transacted as buyers and sellers
select count(DISTINCT u.user_id)
from users u
join (select o.buyer_id, o.seller_id from orders o join users u on o.buyer_id = u.user_id) o 
on u.user_id = o.seller_id;

--get users who never transact as buyers and sellers
select count(DISTINCT u.user_id)
from users u
join (select o.buyer_id, o.seller_id from orders o join users u on o.buyer_id <> u.user_id) o 
on u.user_id <> o.seller_id;

--no 6
select * from orders;

--check if there is a specific email domain from the seller
select DISTINCT SUBSTRING(u.email,CHARINDEX('@',u.email),len(u.email))  
from users u
join orders o
on u.user_id = o.seller_id
where SUBSTRING(u.email,CHARINDEX('@',u.email),len(u.email)) = '@cv.web.id';
