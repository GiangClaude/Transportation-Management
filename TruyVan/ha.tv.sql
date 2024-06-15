use qlgv; 
-- 1. Liệt kê số lượng đơn hàng đã giao thành công theo từng nhân viên giao hàng trong tháng ̀̉̀̀5/2024
SELECT s.EmployeeID, CONCAT(e.FirstName, ' ', e.MiddleName, ' ', e.LastName) AS ShipperName, COUNT(*) AS SoLuongDonHang
FROM Send s
JOIN Shipper e ON s.EmployeeID = e.EmployeeID
WHERE s.SendStatus = 'Thanh cong' 
AND YEAR(s.ActualDate) = 2024 
AND MONTH(s.ActualDate) = 5
GROUP BY s.EmployeeID, ShipperName;

-- 2. Lấy thông tin về các đơn hàng đã qua kho có tên 'Kho Ninh Binh’ vào ngày 29/5/2024
SELECT ie.OrderID, ie.WarehouseID, ie.InboundDate, ie.OutboundDate
FROM ImportExport ie
JOIN Warehouse w ON ie.WarehouseID = w.WarehouseID
WHERE w.WareName = 'Kho Ninh Binh' AND DATE(ie.InboundDate) = '2024-05-29';

-- 3. Shipper giao nhiều đơn hàng nhất vào năm 2023 sẽ được trao danh hiệu “Shipper Star 2023”
ALTER TABLE Shipper
ADD Status VARCHAR(30);

WITH ShipperDeliveries AS (
    SELECT s.EmployeeID, CONCAT(s.FirstName, ' ', s.MiddleName, ' ', s.LastName) AS ShipperName,
        COUNT(sd.OrderID) AS NumberOfDeliveries
    FROM Shipper s
    JOIN Send sd ON s.EmployeeID = sd.EmployeeID
    WHERE YEAR(sd.ReceiptDate) = 2023
    GROUP BY s.EmployeeID, ShipperName
    ORDER BY NumberOfDeliveries DESC
    LIMIT 1
)
UPDATE Shipper
SET Status = 'Shipper Star 2023'
WHERE EmployeeID = (SELECT EmployeeID FROM ShipperDeliveries);
SELECT 
    EmployeeID,
    CONCAT(FirstName, ' ', MiddleName, ' ', LastName) AS ShipperName,
    IF(Status IS NULL, '0000', Status) AS ShipperStatus
FROM Shipper;

ALTER TABLE Shipper
DROP COLUMN Status;

-- 4. Tính toán tổng doanh thu từ dịch vụ vận chuyển theo ngày.
SELECT 
    ActualDate,
    COUNT(DISTINCT p.OrderID) AS TotalOrders,
    SUM(pt.ShipPrice) AS TotalShippingPrice,
    SUM(pt.OrderPrice) AS TotalOrderPrice,
    SUM(pt.OrderCod) AS TotalOrderCod,
    SUM(pt.ShipSurcharge) AS TotalShippingSurcharge,
    SUM(pt.Total) AS TotalPrice
FROM  Send s
JOIN Product p ON s.OrderID = p.OrderID
JOIN PriceTotal pt ON p.OrderID = pt.OrderID
WHERE s.ActualDate IS NOT NULL 
GROUP BY ActualDate
ORDER BY ActualDate;

-- 5. truy vấn số kho mỗi đơn hàng giao thành công đi qua và xác định kho đầu và cuối, sắp xếp tăng dần 
SELECT ie.OrderID, COUNT(ie.WarehouseID) AS NumberOfWarehouses, MIN(w.WareName) AS FirstWarehouse, MAX(w.WareName) AS LastWarehouse
FROM ImportExport ie
JOIN Warehouse w ON ie.WarehouseID = w.WarehouseID
JOIN Send s ON ie.OrderID = s.OrderID
WHERE s.SendStatus = 'Thanh cong'
GROUP BY ie.OrderID
ORDER BY NumberOfWarehouses ASC;

-- 6. Tính tổng số Item của từng phân loại hàng hóa và tỉ lệ % 
SELECT sur.SurchargeID, sur.SurchargeName, COUNT(od.ItemID) AS ItemCount, 
CONCAT(ROUND(COUNT(od.ItemID) * 100.0 / 
(SELECT COUNT(*) FROM OrderDetails), 2), '%') AS Percentage
FROM Surcharge sur
LEFT JOIN OrderDetails od ON sur.SurchargeID = od.SurchargeID
GROUP BY sur.SurchargeID, sur.SurchargeName
;

-- 7. Truy vấn tổng sản phẩm, tổng cân nặng và tổng chi phí liên quan của những đơn có từ 2 sp trở lên
WITH OrderSummary AS (
  SELECT OrderID, COUNT(ItemID) AS TotalItems
  FROM OrderDetails
  GROUP BY OrderID
), OrderTotal AS (
  SELECT p.OrderID, SUM(od.Weight) AS TotalWeight
  FROM Product p
  INNER JOIN OrderDetails od ON p.OrderID = od.OrderID
  GROUP BY p.OrderID
), OrderPriceTotal AS (
  SELECT os.OrderID, os.TotalItems, ot.TotalWeight,
    SUM(pt.ShipPrice) AS TotalShipPrice,
    SUM(pt.OrderPrice) AS TotalOrderPrice,
    SUM(pt.OrderCod) AS TotalOrderCod,
    SUM(pt.ShipSurcharge) AS TotalShipSurcharge,
    SUM(pt.RecipientPay) AS TotalRecipientPay,
    SUM(pt.Total) AS TotalPrice
  FROM OrderSummary os
  INNER JOIN OrderTotal ot ON os.OrderID = ot.OrderID
  INNER JOIN PriceTotal pt ON os.OrderID = pt.OrderID
  WHERE os.TotalItems >= 2
  GROUP BY os.OrderID, os.TotalItems, ot.TotalWeight
)
SELECT OrderID, TotalItems, TotalWeight, TotalShipPrice, TotalOrderPrice, TotalOrderCod, TotalShipSurcharge, TotalRecipientPay, TotalPrice
FROM OrderPriceTotal;

-- 8. Các đơn có ngày giao hàng <= 2 xem là Fast Deliveries, truy vấn ra các kho mà các đơn Fast Deliveries hay đi qua ( có số lần trùng >=2 ) để tham khảo hiệu suất làm việc các kho 
WITH FastDeliveries AS ( 
SELECT OrderID 
FROM Send
WHERE DATEDIFF(ActualDate, ReceiptDate) <= 2 AND SendStatus = 'Thanh cong'
)
SELECT WarehouseID, COUNT(*) AS Frequency
FROM ImportExport
WHERE OrderID IN (SELECT OrderID FROM FastDeliveries)
GROUP BY WarehouseID
HAVING COUNT(*) >= 2
ORDER BY Frequency DESC;
