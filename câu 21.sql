SELECT  
    u.UserID, 
    COALESCE(COUNT(DISTINCT o.OrderID), 0) AS TotalOrders 
FROM  
    AccUser u 
LEFT JOIN  
    OrderCreate oc ON u.UserID = oc.GiverID 
LEFT JOIN  
    Product o ON oc.OrderID = o.OrderID 
GROUP BY  
    u.UserID; 