#Chon so nguoi tao don trong nam 2024, sap xep theo thu tu so don 
select GiverID, count(orderID)
from OrderCreate
where orderDate >= '2024-01-01'
group by GiverID
order by count(orderID) desc;


#Biet nguoi dung co so tien ship tren 1.000.000 hoac co so don > 3 la khach hang tiem nang. Hay liet ke thong tin cua nhung user la kh tiem nang
select * from accuser
where userid in (
	select giverid
	from ordercreate,PriceTotal
	where ordercreate.OrderID = PriceTotal.OrderID
	group by GiverID
	having sum(total) >1000000 or count(ordercreate.orderid) >3
);

#Chon ra nhung nguoi dung tao tai khoan nhung chua gui don nao
select * from accuser
where userid not in (
	select giverid
    from ordercreate
);

#Chọn ra những tk đã từng gửi ở 2 địa chỉ gửi hàng trở lên

use qlgv;
#Chọn ra những tk đã từng gửi đơn hàng có địa chỉ lấy hàng khác địa chỉ user
create index UserAddress on accuser(city,  District, ware, Address);
create index PickupAddress on product(PickupCity, PickupDistrict, PickupWard, PickupAddress);



