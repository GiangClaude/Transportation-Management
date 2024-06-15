SELECT  
    YEAR(OrderDate) AS Year, 
    MONTH(OrderDate) AS Month, 
    COUNT(OrderID) AS TotalOrders 
FROM  
    OrderCreate 
GROUP BY  
    YEAR(OrderDate), MONTH(OrderDate) 
ORDER BY  
    Year, Month; 