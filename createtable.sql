create database qlgv;
use qlgv;
# tao bang kho
CREATE TABLE Warehouse (
    WarehouseID CHAR(4) PRIMARY KEY,
    WareName VARCHAR(30) NOT NULL,
    City VARCHAR(40) NOT NULL,
    District VARCHAR(30),
    Ward VARCHAR(30),
    Address VARCHAR(30)
);

#tao bang dich vu
CREATE TABLE Service (
    ServiceID CHAR(5) PRIMARY KEY,
    ServiceName VARCHAR(20),
    Price DECIMAL(12,3) not null,
    MaxDistance SMALLINT
);
alter table Service
modify MaxDistance char(6); 

# tao bang don hang
CREATE TABLE Product (
    OrderID CHAR(5) PRIMARY KEY,
#   Total DECIMAL(12,3) not null,
    Payer VARCHAR(15) not null,
    PickupCity VARCHAR(50) not null,
    PickupDistrict VARCHAR(30),
    PickupWard VARCHAR(30),
    PickupAddress VARCHAR(45) not null,
    DeliveryCity VARCHAR(50),
    DeliveryDistrict VARCHAR(45),
    DeliveryWard VARCHAR(45),
    DeliveryAddress VARCHAR(45) not null,
    RecipientName VARCHAR(30) not null,
    PhoneRecipient VARCHAR(15) not null,
    CurrentWarehouseID CHAR(5) default 'K000',
    OrderStatus VARCHAR(20) default 'Dang xu ly',
    ServiceID CHAR(5)
);
#them constraint cho ServiceID
ALTER TABLE Product
ADD CONSTRAINT Service_ID
FOREIGN KEY (ServiceID) REFERENCES Service(ServiceID)
on delete cascade
on update cascade;

#bang nhap kho / xuat kho
CREATE TABLE ImportExport (
    WarehouseID CHAR(5),
    OrderID CHAR(5),
    InboundDate DATE not null,
    OutboundDate DATE default NUll,
    constraint ID primary key (WarehouseID, OrderID),
    constraint Warehouse_ID foreign key (WarehouseID) REFERENCES Warehouse(WarehouseID)
    on delete cascade
	on update cascade,
    constraint OrderID foreign key (OrderID) REFERENCES Product(OrderID)
    on delete cascade
	on update cascade
);

# bang nguoi dung
CREATE TABLE AccUser (
    UserID CHAR(5) PRIMARY KEY,
    LastName VARCHAR(10),
    MiddleName VARCHAR(10),
	FirstName VARCHAR(10) not null,
    Birthday DATE,
    Gender CHAR(3),
    Phone VARCHAR(10) unique not null,
    City VARCHAR(30),
    District VARCHAR(45),
    Ware VARCHAR(45),
    Address VARCHAR(45)
);

#bang tao don hang
CREATE TABLE OrderCreate (
    UserID CHAR(5),
    OrderID CHAR(5),
    OrderDate DATE not null,
    constraint Create_ID primary key (UserID, OrderID),
    constraint User_ID foreign key (UserID) REFERENCES AccUser(UserID)
    on delete cascade
	on update cascade,
    constraint Order_ID foreign key (OrderID) REFERENCES Product(OrderID)
    on delete cascade
	on update cascade
);

CREATE TABLE Shipper (
    EmployeeID CHAR(5) PRIMARY KEY,
    LastName VARCHAR(10),
    MiddleName VARCHAR(10),
    FirstName VARCHAR(10) not null,
    Gender CHAR(6),
    Birthday DATE,
    Phone VARCHAR(10) unique not null,
    Address VARCHAR(45) not null,
    Ward VARCHAR(45),
    District VARCHAR(45),
    City VARCHAR(30)
);

CREATE TABLE Send (
    EmployeeID CHAR(5),
    OrderID CHAR(5),
    ReceiptDate DATE, #ngay nhan don
    EstimatedDate DATE, # ngay giao hang du kien = ngay nhan don + 4
    ActualDate DATE, # ngay giao hang thuc te - tu nhap
    constraint SendID primary key (EmployeeID, OrderID),
    constraint Employee_ID foreign key (EmployeeID) REFERENCES Shipper(EmployeeID)
    on delete cascade
	on update cascade,
    constraint foreign key (OrderID) REFERENCES Product(OrderID)
    on delete cascade
	on update cascade
);



create table Surcharge (
	SurchargeID char(5) primary key,
    SurchargeName varchar(20),
    Price decimal(5,2)
);

create table OrderDetails (
    ItemID char(10),
    OrderID char(5),
    ItemName varchar(30) not null,
    SurchargeID varchar(20),
    Weight decimal(18,2) not null,
    constraint DetailsID primary key (ItemID, OrderID),
    constraint foreign key (OrderID) REFERENCES Product(OrderID)
    on delete cascade
	on update cascade,
    constraint foreign key (SurchargeID) REFERENCES Surcharge(SurchargeID)
    on delete cascade
	on update cascade
);
alter table OrderDetails
modify itemprice decimal(20,3);

alter table orderdetails 
drop primary key;   
alter table orderdetails
add primary key(ItemID); 


