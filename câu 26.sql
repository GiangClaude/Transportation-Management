SELECT  
    DATE(OrderDate) AS `Ngày đặt hàng`, 
    COUNT(*) AS `Số lượng đơn hàng` 
FROM  
    OrderCreate 
WHERE 
(  
	DAY(OrderDate) = MONTH(OrderDate) 
	AND YEAR(OrderDate) = 2022 
) 
GROUP BY  
    DATE(OrderDate) 
ORDER BY  
    `Ngày đặt hàng` DESC;