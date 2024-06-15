SELECT  
    UserID, 
    FirstName, 
    LastName, 
    Birthday 
FROM  
    AccUser 
WHERE  
    MONTH(Birthday) = MONTH(CURRENT_DATE()) 
    AND DAY(Birthday) >= DAY(CURRENT_DATE()) 
ORDER BY  
    DAY(Birthday)