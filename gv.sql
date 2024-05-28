create database qlgv;
use qlgv;
CREATE TABLE Warehouse (
    WarehouseID CHAR(4) PRIMARY KEY,
    WareName VARCHAR(30) NOT NULL,
    City VARCHAR(40) NOT NULL,
    District VARCHAR(30),
    Ward VARCHAR(30),
    Address VARCHAR(30)
);

CREATE TABLE Product (
    OrderID CHAR(5) PRIMARY KEY,
    Total DECIMAL(12,3) not null,
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
    PhoneRecipient VARCHAR(15) not null unique,
    CurrentWarehouseID CHAR(5) default 'K000',
    OrderStatus VARCHAR(20) default 'Dang xu ly'
);

CREATE TABLE ImportExport (
    WarehouseID CHAR(5),
    OrderID CHAR(5),
    InboundDate DATE not null,
    OutboundDate DATE default NUll,
    constraint ID primary key (WarehouseID, OrderID),
    FOREIGN KEY (WarehouseID) REFERENCES Warehouse(WarehouseID),
    FOREIGN KEY (OrderID) REFERENCES Product(OrderID)
);

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

CREATE TABLE OrderCreate (
    UserID CHAR(5),
    OrderID CHAR(5),
    OrderDate DATE not null,
    constraint Create_ID primary key (UserID, OrderID),
    FOREIGN KEY (UserID) REFERENCES AccUser(UserID),
    FOREIGN KEY (OrderID) REFERENCES Product(OrderID)
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
    ReceiptDate DATE,
    EstimatedDate DATE,
    ActualDate DATE,
    constraint SendID primary key (EmployeeID, OrderID),
    FOREIGN KEY (EmployeeID) REFERENCES Shipper(EmployeeID),
    FOREIGN KEY (OrderID) REFERENCES Product(OrderID)
);

CREATE TABLE Service (
    ServiceID CHAR(5) PRIMARY KEY,
    ServiceName VARCHAR(20),
    Price DECIMAL(12,3) not null,
    MaxDistance SMALLINT
);

CREATE TABLE UseService (
    OrderID CHAR(5),
    ServiceID CHAR(5),
    constraint UseServiceID primary key (ServiceID, OrderID),
    FOREIGN KEY (OrderID) REFERENCES Product(OrderID),
    FOREIGN KEY (ServiceID) REFERENCES Service(ServiceID)
);

create table OrderDetails (
    ItemID char(10),
    OrderID char(5),
    ItemName varchar(30) not null,
    ItemType varchar(20),
    Weight decimal(18,2) not null,
    constraint DetailsID primary key (ItemID, OrderID),
    FOREIGN KEY (OrderID) REFERENCES Product(OrderID)
);

create table Surcharge (
	SurchargeID char(5) primary key,
    SurchargeName varchar(20),
    Price decimal(5,2)
);