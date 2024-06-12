-- Liệt kê số lượng đơn hàng đã giao thành công theo từng nhân viên giao hàng trong tháng 6/2024
SELECT s.EmployeeID, e.FirstName, e.LastName, COUNT(*) AS SoLuongDonHang
FROM Send s
JOIN Shipper e ON s.EmployeeID = e.EmployeeID
WHERE s.SendStatus = 'Thanh cong' 
AND YEAR(s.ReceiptDate) = 2024 
AND MONTH(s.ReceiptDate) = 6
GROUP BY s.EmployeeID, e.FirstName, e.LastName;
-- Lấy thông tin về các đơn hàng đã qua kho có tên 'Kho Ninh Binh’ vào ngày 29/5/2024
SELECT *
FROM ImportExport ie
JOIN Warehouse w ON ie.WarehouseID = w.WarehouseID
WHERE w.WarehouseName = 'Kho Ninh Binh' AND DATE(ie.InboundDate) = '2024-05-29';
-- Shipper giao nhiều đơn hàng nhất vào năm 2023 sẽ được trao danh hiệu “Shipper Star 2023”
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
WHERE EmployeeID = (SELECT s.EmployeeID FROM Shipper s
    JOIN Send sd ON s.EmployeeID = sd.EmployeeID
    WHERE YEAR(sd.ReceiptDate) = 2023
    GROUP BY  s.EmployeeID
    ORDER BY COUNT(sd.OrderID) DESC
    LIMIT 1
);
ALTER TABLE Shipper
ADD Status VARCHAR(30);
-- Truy vấn các tài khoản hoàn 15 đơn hàng trở lên vào danh sách "Tai khoan han che"
ALTER TABLE AccUser
ADD Status VARCHAR(30);

UPDATE AccUser
SET Status = 'Tai khoan han che'
WHERE UserID IN (
    SELECT oc.ReciverID
    FROM OrderCreate oc
    JOIN Send s ON oc.OrderID = s.OrderID
    WHERE s.SendStatus = 'Hoan' -- Điều chỉnh giá trị trạng thái để phù hợp với chỉ báo trạng thái hoàn
    GROUP BY oc.ReciverID
    HAVING COUNT(*) >= 15
); 
-- Truy vấn các sản phẩm được đặt lại bởi cùng 1 khách hàng.
SELECT 
    od.ItemID,
    od.ItemName,
    COUNT(DISTINCT od.OrderID) AS TotalOrders,
    GROUP_CONCAT(DISTINCT od.OrderID ORDER BY od.OrderID) AS OrderIDs,  
    p.Payer AS AccountID
FROM OrderDetails od
JOIN Product p ON od.OrderID = p.OrderID
GROUP BY od.ItemID, od.ItemName, p.Payer
HAVING COUNT(DISTINCT od.OrderID) >= 2;
-- Truy vấn thông tin 5 tài khoản nhận hàng nhiều đơn hàng nhất từ tài khoản người gửi có userID U005 và sắp xếp theo tổng số tiền các đơn của mỗi tài khoản theo thứ tự giảm dần. 
SELECT p.RecipientName, SUM(o.Price) AS TotalPrice
FROM Product p
JOIN Send s ON p.OrderID = s.OrderID
JOIN OrderCreate oc ON p.OrderID = oc.OrderID
JOIN AccUser a ON p.RecipientName = a.UserID
JOIN OrderDetails o ON p.OrderID = o.OrderID
WHERE oc.GiverID = 'U005' 
AND s.SendStatus = 'Thanh cong' 
GROUP BY p.RecipientName
ORDER BY TotalPrice DESC
LIMIT 5;
-- Truy vấn để tìm tất cả các vai trò mà người dùng 'sender_user' có và liệt kê tất cả các quyền liên quan.
SELECT r.name as role_name, p.name as permission_name
FROM users u
JOIN user_roles ur ON u.id = ur.user_id
JOIN roles r ON ur.role_id = r.id
JOIN role_permissions rp ON r.id = rp.role_id
JOIN permissions p ON rp.permission_id = p.id
WHERE u.username = 'sender_user'
ORDER BY r.name, p.name;
-- Tính toán tổng doanh thu từ dịch vụ vận chuyển theo ngày.
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