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

















#index
create index give_id on OrderCreate(GiverID);
create index order_status on Statusofproduct(OrderStatus);
# ty le don hang giao thanh cong, bi huy, bi hoan cua tung account
# drop function  Successpercent;
DELIMITER $$
CREATE FUNCTION Successpercent(UserID CHAR(5))
RETURNS DECIMAL(5,2)
DETERMINISTIC 
BEGIN
    DECLARE success_rate DECIMAL(5,2) DEFAULT 0.00;
    -- Tạo bảng tạm thời chứa các đơn hàng và trạng thái đơn mà UserID đã đặt
    WITH CTEtable AS (
        SELECT POG.OrderID AS Orde, S.OrderStatus AS Sttus
        FROM Statusofproduct AS S
        INNER JOIN (
            SELECT OrderID
            FROM OrderCreate
            WHERE GiverID = UserID
        ) AS POG ON S.OrderID = POG.OrderID
    )
    SELECT ROUND((CAST((SELECT COUNT(Orde) FROM CTEtable WHERE Sttus = 'Thanh cong') AS DECIMAL) 
                  / COUNT(Orde)) * 100, 2)
    INTO success_rate
    FROM CTEtable;
    RETURN success_rate;
END$$
DELIMITER ;

SELECT distinct UserID, 
CASE 
    When userid in (select distinct giverid from ordercreate) then Successpercent(UserID) 
    else 0.00
    end AS `Tỷ lệ đơn hàng được giao thành công`
FROM accuser
Order by UserID;

#trong tat ca cac don hang da gui thi so don hang thanh cong, hoan, huy lan luot la
select * from Statusofproduct;
select Round(((select count(orderID) from Statusofproduct
		 where OrderStatus = 'Thanh cong'
		 group by OrderStatus) / count(OrderID)) * 100, 2)
	   as `Tỷ lệ đơn hàng được giao thành công`,
       Round(((select count(orderID) from Statusofproduct
		 where OrderStatus = 'Hoan'
		 group by OrderStatus) / count(OrderID)) * 100, 2)
	   as `Tỷ lệ đơn hàng bị hoàn lại`,
       Round(((select count(orderID) from Statusofproduct
		 where OrderStatus = 'Don hang da bi huy'
		 group by OrderStatus) / count(OrderID)) * 100, 2)
	   as `Tỷ lệ đơn hàng đã bị hủy`
from Statusofproduct;
