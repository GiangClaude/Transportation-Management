DELIMITER $$ 
  
CREATE PROCEDURE GetWarehouseOrderDetails() 
BEGIN 
    SELECT   
        w.WarehouseID,  
        w.WareName,  
        w.City,  
        w.District,  
        w.Ward,  
        w.Address,  
        COUNT(ie.OrderID) AS TotalOrders,  
        GROUP_CONCAT(sp.OrderID SEPARATOR ', ') AS OrderList  
    FROM   
        Warehouse w  
    LEFT JOIN   
        ImportExport ie ON w.WarehouseID = ie.WarehouseID AND ie.OutboundDate IS NULL  
    LEFT JOIN   
        Statusofproduct sp ON ie.OrderID = sp.OrderID AND sp.CurrentWarehouseID = w.WarehouseID  
    GROUP BY   
        w.WarehouseID, w.WareName, w.City, w.District, w.Ward, w.Address  
    ORDER BY   
        w.WarehouseID; 
END $$ 
DELIMITER ; 