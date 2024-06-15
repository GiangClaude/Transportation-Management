use qlgv; 
-- 1. Liệt kê số lượng đơn hàng đã giao thành công theo từng nhân viên giao hàng trong tháng 6/2024
SELECT s.EmployeeID, e.FirstName, e. MiddleName, e.LastName, COUNT(*) AS SoLuongDonHang
FROM Send s
JOIN Shipper e ON s.EmployeeID = e.EmployeeID
WHERE s.SendStatus = 'Thanh cong' 
AND YEAR(s.ReceiptDate) = 2024 
AND MONTH(s.ReceiptDate) = 5
GROUP BY s.EmployeeID, e.FirstName, e. MiddleName, e.LastName;
-- 2. Lấy thông tin về các đơn hàng đã qua kho có tên 'Kho Ninh Binh’ vào ngày 29/5/2024
SELECT *
FROM ImportExport ie
JOIN Warehouse w ON ie.WarehouseID = w.WarehouseID
WHERE w.WareName = 'Kho Ninh Binh' AND DATE(ie.InboundDate) = '2024-05-29';
-- 3. Shipper giao nhiều đơn hàng nhất vào năm 2023 sẽ được trao danh hiệu “Shipper Star 2023”
ALTER TABLE Shipper
ADD Status VARCHAR(30);
SELECT 
    s.EmployeeID,
    CONCAT(s.FirstName, ' ', s.MiddleName, ' ', s.LastName) AS ShipperName,
    COUNT(sd.OrderID) AS NumberOfDeliveries
FROM  Shipper s
JOIN Send sd ON s.EmployeeID = sd.EmployeeID
WHERE YEAR(sd.ReceiptDate) = 2023
GROUP BY s.EmployeeID, ShipperName
ORDER BY NumberOfDeliveries DESC
LIMIT 1;
-- Update status "Shipper Star 2023"
UPDATE Shipper 
SET Status = 'Shipper Star 2023' 
WHERE EmployeeID = (
    SELECT subquery.EmployeeID
    FROM (
        SELECT s.EmployeeID, COUNT(sd.OrderID) AS OrderCount
        FROM Shipper s
        JOIN Send sd ON s.EmployeeID = sd.EmployeeID
        WHERE YEAR(sd.ReceiptDate) = 2023
        GROUP BY s.EmployeeID
        ORDER BY OrderCount DESC
        LIMIT 1
    ) AS subquery
);
SELECT 
    EmployeeID,
    CONCAT(FirstName, ' ', MiddleName, ' ', LastName) AS ShipperName,
    IF(Status IS NULL, '0000', Status) AS ShipperStatus
FROM Shipper;
ALTER TABLE Shipper
DROP COLUMN Status;
-- 4. Tính toán tổng doanh thu từ dịch vụ vận chuyển theo ngày.
SELECT 
    Date(ActualDate) AS DeliveryDate,
    COUNT(DISTINCT p.OrderID) AS TotalOrders,
    SUM(pt.ShipPrice) AS TotalShippingPrice,
    SUM(pt.OrderPrice) AS TotalOrderPrice,
    SUM(pt.OrderCod) AS TotalOrderCod,
    SUM(pt.ShipSurcharge) AS TotalShippingSurcharge,
    SUM(pt.Total) AS TotalRevenue
FROM  Send s
JOIN Product p ON s.OrderID = p.OrderID
JOIN PriceTotal pt ON p.OrderID = pt.OrderID
WHERE s.ActualDate IS NOT NULL 
GROUP BY DeliveryDate
ORDER BY DeliveryDate;
-- 5. Truy vấn để tìm tất cả các vai trò mà người dùng 'sender_user' có và liệt kê tất cả các quyền liên quan.
SELECT r.name as role_name, p.name as permission_name
FROM users u
JOIN user_roles ur ON u.id = ur.user_id
JOIN roles r ON ur.role_id = r.id
JOIN role_permissions rp ON r.id = rp.role_id
JOIN permissions p ON rp.permission_id = p.id
WHERE u.username = 'sender_user'
ORDER BY r.name, p.name;
-- 6. Truy vấn thông tin 3 tài khoản nhận hàng nhiều đơn hàng nhất từ tài khoản người gửi có userID U019 và sắp xếp theo tổng số tiền đơn hàng mà người đó nhận giảm dần
SELECT oc.ReciverID, a.LastName, a. MiddleName, a.FirstName,  
    SUM(o.ItemPrice) AS TotalItemPrice, 
    SUM(pt.Total) AS TotalPrice
FROM OrderCreate oc
JOIN AccUser a ON oc.ReciverID = a.UserID
JOIN OrderDetails o ON oc.OrderID = o.OrderID
JOIN PriceTotal pt ON o.OrderID = pt.OrderID
WHERE oc.GiverID = 'U019'
GROUP BY oc.ReciverID, a.LastName, a. MiddleName, a.FirstName
ORDER BY TotalPrice DESC
LIMIT 3;
-- 7. truy vấn số kho mỗi đơn hàng giao thành công đi qua của mỗi đơn và tính tb, sắp xếp tăng dần 
SELECT ie.OrderID, COUNT(ie.WarehouseID) AS NumberOfWarehouses, FLOOR(AVG(COUNT(ie.WarehouseID)) OVER ()) AS AverageNumberOfWarehouses
FROM ImportExport ie
JOIN Warehouse w ON ie.WarehouseID = w.WarehouseID
JOIN Send s ON ie.OrderID = s.OrderID
WHERE s.SendStatus = 'Thanh cong'
GROUP BY ie.OrderID
ORDER BY NumberOfWarehouses asc;






