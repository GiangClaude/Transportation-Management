CREATE DATABASE GIAOVAN;
USE GIAOVAN;
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
INSERT INTO Shipper (EmployeeID, LastName, MiddleName, FirstName, Gender, Birthday, Phone, Address, Ward, District, City)
VALUES
  ('SP001', 'Nguyen', 'Van', 'Anh', 'Male', '1990-07-15', '0987123456', 'So 10, Duong Tran Hung Dao', 'Dong Hoa', 'Cau Giay', 'Ha Noi'),
  ('SP002', 'Tran', 'Thi', 'Binh', 'Female', '1995-03-02', '0912345678', 'So 25, Duong Nguyen Van Linh', 'An Phu', 'Quan 2', 'Ho Chi Minh'),
  ('SP003', 'Le', 'Hong', 'Cuong', 'Male', '1988-11-10', '0905678901', 'So 8, duong Tran Phu', 'Nghia Chanh', 'Hai Chau', 'Da Nang'),
  ('SP004', 'Pham', 'Thi', 'Dung', 'Female', '1992-09-25', '0978234567', 'So 35, duong Le Thanh Loi', 'Ben Thanh', 'Quan 1', 'Ho Chi Minh'),
  ('SP005', 'Hoang', 'Minh', 'Duc', 'Male', '1993-05-08', '0943567890', 'So 12, duong Ly Thuong Kiet', 'Tran Hung Dao', 'Hoan Kiem', 'Ha Noi'),
  ('SP006', 'Tran', 'Van', 'Hai', 'Male', '1991-12-12', '0966789012', 'So 17A, duong Tran Quang Khai', 'Tan Dinh', 'Quan 1', 'Ho Chi Minh'),
  ('SP007', 'Hoang', 'Thu', 'Ha', 'Female', '1994-09-03', '0934012345', 'So 5, duong Nguyen Van Cu', 'An Hoa', 'Ninh Kieu', 'Can Tho'),
  ('SP008', 'Le', 'Thi', 'Kim Anh', 'Female', '1996-06-18', '0956345678', 'So 22, duong Mai Dien Thi Luu', 'Thao Dien', 'Quan 2', 'Ho Chi Minh'),
  ('SP009', 'Chu', 'Thi', 'Mai', 'Female', '1990-04-29', '0923678901', 'So 14, duong Le An Loi', 'Truong An', 'Ninh Kieu', 'Can Tho'),
  ('SP010', 'Le', 'Van', 'Quang', 'Male', '1986-11-07', '0999901234', 'So 22, duong Ly Tu Trong', 'Ben Thanh', 'Quan 1', 'Ho Chi Minh'),
  ('SP011', 'Tran', 'Quoc', 'Anh', 'Male', '1989-12-11', '0907234567', 'So 9, duong Tran Phu', 'Phan Chu Trinh', 'Hoan Kiem', 'Ha Noi'),
  ('SP012', 'Pham', 'Minh', 'Nhat', 'Male', '1994-05-01', '0945567890', 'So 18, duong Nguyen Dinh Chieu', 'Da Kao', 'Quan 1', 'Ho Chi Minh'),
  ('SP013', 'Lai', 'Thien', 'Loc', 'Male', '1997-09-14', '0988789012', 'So 7, duong Tran Quang Khai', 'An Hoa', 'Ninh Kieu', 'Can Tho'),
  ('SP014', 'Nguyen', 'Trung', 'Dung', 'Male', '1998-03-05', '0919012345', 'So 11, duong Nguyen Huu Canh', 'Phuong 22', 'Binh Thanh', 'Ho Chi Minh'),
  ('SP015', 'Dinh', 'Van', 'Hung', 'Male', '1996-11-19', '0967345678', 'So 6, duong Tran Phu', 'Cai Khe', 'Ninh Kieu', 'Can Tho'), 
  ('SP016', 'Le', 'Quoc', 'Huy', 'Male', '1993-08-27', '0935678901', 'So 16, duong Ly Thuong Kiet', 'Ben Nghe', 'Quan 1', 'Ho Chi Minh'),
  ('SP017', 'Tran', 'Dinh', 'Nhat Minh', 'Male', '1999-06-14', '0972901234', 'So 4, duong Nguyen Van Linh', 'Phu My Hung', 'Quan 7', 'Ho Chi Minh'),
  ('SP018', 'Vu', 'Thi', 'Quynh', 'Female', '1987-02-03', '0909234567', 'So 13, duong Mai Dien Thi Luu', 'Thao Dien', 'Quan 2', 'Ho Chi Minh'),
  ('SP019', 'Le', 'Minh', 'Khue', 'Female', '1984-06-06', '0946567890', 'So 20, duong Tran Quang Khai', 'An Hoa', 'Ninh Kieu', 'Can Tho'),
  ('SP020', 'Vu', 'Manh', 'Quan', 'Male', '1992-12-17', '0969789012', 'So 10, duong Nguyen Chi Thanh','Lam Ha', 'Phu Ly', 'Ha Nam');

CREATE TABLE Warehouse (
    WarehouseID CHAR(4) PRIMARY KEY,
    WareName VARCHAR(30) NOT NULL,
    City VARCHAR(40) NOT NULL,
    District VARCHAR(30),
    Ward VARCHAR(30),
    Address VARCHAR(30)
);
INSERT INTO Warehouse (WarehouseID, WareName, Address, Ward, District, City)
VALUES
  ('W001', 'Hung Gia', '123, Duong Hoang Van Thu', 'Tan Binh', 'Quan 1', 'Ho Chi Minh'),
  ('W002', 'Minh Phat', '456, Duong Nguyen Van Linh', 'Trung Hoa', 'Cau Giay', 'Ha Noi'),
  ('W003', 'An Binh', '321, Duong Tran Phu', 'Vinh Nguyen', 'Le Chan', 'Hai Phong'),
  ('W004', 'Long Thanh', '654, Duong Ngo Gia Tu', 'Tran Hung Dao', 'Ngo Quyen', 'Hai Duong'),
  ('W005', 'Bac Hai', '987, Duong Truong Chinh', 'Ben Thanh', 'Quan 3', 'Ho Chi Minh'),
  ('W006', 'Phuc Thinh', '135, Duong Bach Dang Bac', 'Hoa Cuong', 'Hai Chau', 'Da Nang'),
  ('W007', 'Tan Son', '246, Duong Mai Xuan Thuong', 'Xuan Ha', 'Thanh Khe', 'Da Nang'),
  ('W008', 'Hoang Long', '753, Duong Ly Thuong Kiet', 'Nguyen Du', 'Hoan Kiem', 'Ha Noi'),
  ('W009', 'Dai Loi', '864, Duong Le Van Sy', 'Phuong 13', 'Quan 3', 'Ho Chi Minh'),
  ('W010', 'Nam Son', 'Ngo 1 Thuy Linh', 'Linh Nam', 'Hai Ba Trung', 'Ha Noi'),
  ('W011', 'Hai Dang', '753, Duong Le Duan', 'Ben Nghe', 'Quan 1', 'Ho Chi Minh'),
  ('W012', 'Thanh Cong', '864, Duong Nguyen Van Cu', 'An Hoa', 'Ninh Kieu', 'Can Tho'),
  ('W013', 'Ngoc Lan', '135, Duong Tran Hung Dao', 'Xuan Phu', 'Ha Dong', 'Ha Noi'),
  ('W014', 'Phat Tai', '987, Duong Tran Quang Khai', 'Ben Thanh', 'Quan 1', 'Ho Chi Minh'),
  ('W015', 'Tien Phat', '155, Duong Tran Dai Nghia', 'Bach Khoa', 'Hai Ba Trung', 'Ha Noi');
  
CREATE TABLE Service (
    ServiceID CHAR(5) PRIMARY KEY,
    ServiceName VARCHAR(20),
    Price DECIMAL(12,3) not null,
    MaxDistance SMALLINT
);
INSERT INTO Service (ServiceID, ServiceName, MaxDistance, Price)
VALUES
    ('S101', 'Economy', '50', 10000),
    ('S102', 'Economy', '100', 22000),
    ('S103', 'Economy', '200', 26000),
    ('S104', 'Economy', '300', 32000),
    ('S105', 'Economy', NULL, 48000),
    ('S201', 'Express', '50', 18000),
    ('S202', 'Express', '100', 30000),
    ('S203', 'Express', '200', 34000),
    ('S204', 'Express', '300', 40000),
    ('S205', 'Express', NULL, 56000),
    ('S301', 'LargeItem', '50', 40000),
    ('S302', 'LargeItem', '100', 67000),
    ('S303', 'LargeItem', '200', 88000),
    ('S304', 'LargeItem', '300', 115000),
    ('S305', 'LargeItem', NULL , 132000);
