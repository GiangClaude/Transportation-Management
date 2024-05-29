-- Thêm phần này vào cuối file gv nhá
-- Tạo bảng log để lưu trữ thông tin cập nhật của Warehouse
CREATE TABLE WarehouseLog (
    LogID INT AUTO_INCREMENT PRIMARY KEY,
    WarehouseID CHAR(4),
    OldWareName VARCHAR(30),
    NewWareName VARCHAR(30),
    OldCity VARCHAR(40),
    NewCity VARCHAR(40),
    OldDistrict VARCHAR(30),
    NewDistrict VARCHAR(30),
    OldWard VARCHAR(30),
    NewWard VARCHAR(30),
    OldAddress VARCHAR(30),
    NewAddress VARCHAR(30),
    ChangeTime TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tạo trigger để lưu trữ thông tin cập nhật vào bảng log sau mỗi lần cập nhật bảng Warehouse
DELIMITER //

CREATE TRIGGER after_warehouse_update
AFTER UPDATE ON Warehouse
FOR EACH ROW
BEGIN
    INSERT INTO WarehouseLog (WarehouseID, OldWareName, NewWareName, OldCity, NewCity, OldDistrict, NewDistrict, OldWard, NewWard, OldAddress, NewAddress)
    VALUES (OLD.WarehouseID, OLD.WareName, NEW.WareName, OLD.City, NEW.City, OLD.District, NEW.District, OLD.Ward, NEW.Ward, OLD.Address, NEW.Address);
END //

DELIMITER ;
