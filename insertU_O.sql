use qlgv;
INSERT INTO AccUser (UserID, LastName, MiddleName, FirstName, Birthday, Gender, Phone, City, District, Ware, Address) VALUES
('U001', 'Le', 'Thi', 'Cuc', '2003-03-25', 'Nu', '0934567890', 'Hue', 'Phu Hoi', 'Phu Nhuan', 'So 6 Phu Nhuan'),
('U002', 'Ngo', 'Van', 'Khoa', '2003-02-04', 'Nam', '0989012345', 'Quang Tri', 'Hai Lang', 'Thi tran Lang Co', '723 Duong Truong Son'),
('U003', 'Tran', 'Van', 'Quang', '2007-12-01', 'Nam', '0934567089', 'Ha Noi', 'Hai Ba Trung', 'Thanh Nhan', '456 Duong Le Dai Hanh'),
('U004', 'Pham', 'Van', 'Dung', '1975-04-14', 'Nam', '0945678901', 'TP. Ho Chi Minh', 'Binh Thanh', 'Phuong 11', '123 Duong D2'),
('U005', 'Bui', 'Van', 'Minh', '1981-10-23', 'Nam', '0912345076', 'Bac Giang', 'Yen The', 'Xa Yen The', '45 Duong Dong Lac'),
('U006', 'Nguyen', 'Van', 'An', '2001-01-12', 'Nam', '0912345678', 'Ha Noi', 'Hoan Kiem', 'Phuong Trang Tien', '723 Pho Hue'),
('U007', 'Vo', 'Thi', 'Mai', '2000-03-25', 'Nu', '0962234123', 'Thai Nguyen', 'Thanh pho Thai Nguyen', 'Phuong Quang Vinh', '449 Duong Quang Trung'),
('U008', 'Đo', 'Thi', 'Quynh', '1995-07-15', 'Nu', '0978901234', 'Ha Noi', 'Hoan Kiem', 'Phuong Hang Bai', '875 Pho Trang Tien'),
('U009', 'Tran', 'Thi', 'Bich', '2002-02-16', 'Nu', '0923456789', 'TP. Ho Chi Minh', 'Quan 1', 'Phuong 9', '789 Duong Nguyen Van Nghi'),
('U010', 'Hoang', 'Van', 'Phong', '1992-07-10', 'Nam', '0967890123', 'TP. Ho Chi Minh', 'Go Vap', 'Phường Phú Nhuận', '185 Hùng Vương'),
('U011', 'Le', 'Thi', 'Hanh', '1984-01-02', 'Nu', '0945678091', 'Tien Giang', 'Cai Lay', 'Thi tran Cai Lay', '123 Duong My Thanh An'),
('U012', 'Vo', 'Thi', 'Em', '2002-12-05', 'Nu', '0956789012', 'Can Tho', 'Cai Rang', 'An Khanh', 'So 14 An Khanh'),
('U013', 'Duong', 'Thi', 'Lan', '1997-09-25', 'Nu', '0990123456', 'Hai Phong', 'Ngo Quyen', 'Le Chan', 'So 23A Le Chan'),
('U014', 'Tran', 'Van', 'Minh', '1996-09-22', 'Nam', '0952389012', 'Lao Cai', 'Huyen Sa Pa', 'Xa Sa Pa', '333 Duong Phan Xi Pang'),
('U015', 'Nguyen', 'Thi', 'Ngoc', '2007-11-05', 'Nu', '0923456078', 'Ha Noi', 'Long Bien', 'Phuong Ngoc Lam', '24 Ngo Tram');
select * from accuser;
#Cái dưới này để nếu sai thì xóa nhập lại thui
delete from accuser
where userID like "U%";
INSERT INTO Product (OrderID, Total, Payer, PickupCity, PickupDistrict, PickupWard, PickupAddress, RecipientName, 
		DeliveryCity, DeliveryDistrict, DeliveryWard, DeliveryAddress, PhoneRecipient, CurrentWarehouseID, OrderStatus
) VALUES
('P001', 70000.00, 'Nguoi nhan', 'Can Tho', 'Cai Rang', 'Le Binh',
 'So 14 An Khanh', 'Duong Thi Lan', 'Hai Phong', 'Ngo Quyen', 'Le Chan',
 'So 23A Le Chan', '0912345678', 'W001', 'Dang xu ly'),
('P002', 23000.00, 'Nguoi gui', 'TP. Ho Chi Minh', 'Go Vap', 'Phường Phú Nhuận', 
'185 Hùng Vương', 'Pham Hai Anh', 'TP. Ho Chi Minh', 'Quan 1', 'Ben Nghe',
 'So 49 Ben Nghe',  '0987654321', 'W009', 'Dang giao hang'),
('P003', 53000.00, 'Nguoi nhan', 'Can Tho', 'Ninh Kieu', 'Cai Khe',
 'So 84B Cai Khe', 'Le Thi Cuc', 'Hue', 'Phu Hoi', 'Phu Nhuan',
 'So 6 Phu Nhuan', '0975316428', 'W001', 'Da giao hang'),
('P004', 170000.00, 'Nguoi gui', 'Hai Phong', 'Le Chan', 'Tran Nguyen Han',
 'So 79A Tran Nguyen Han', 'Nguyen Phu Quynh Lam', 'Quang Ninh', 'Ha Long', 'Bai Chay',
 'So 1 Bai Chay', '0963125478', 'W006', 'Dang xu ly'),
('P005', 20500.00, 'Nguoi nhan', 'Ha Noi', 'Hai Ba Trung', 'Thanh Nhan',
 '456 Duong Le Dai Hanh', 'Pham Hoang Phuc Khang', 'Ha Noi', 'Ba Dinh', 'Ngoc Ha',
 'So 10 Ngoc Ha', '0932154789', 'W005', 'Dang giao hang'),
('P006', 45000.00, 'Nguoi gui', 'Quang Tri', 'Dong Ha', 'Hai Ba Trung',
 'So 112 Hai Ba Trung',  'Tran Van Luong', 'Da Nang', 'Son Tra', 'Phuoc My',
 'So 07A Phuoc My', '0912345897', 'W011', 'Da giao hang'),
('P007', 46000.00, 'Nguoi gui', 'Can Tho', 'Cai Rang', 'An Khanh',
 'So 11 An Khanh',  'Vo Trung Nghia', 'TP. Ho Chi Minh', 'Quan 3', 'Vo Thi Sau',
 'So 101/6 Vo Thi Sau', '0945687123', 'W001', 'Dang xu ly'),
('P008', 200000.00, 'Nguoi nhan', 'Hue', 'Thuan Hoa', 'Kim Long',
 'So 60c Kim Long', 'Vo Thi Em', 'Can Tho', 'Cai Rang', 'An Khanh', 'So 14 An Khanh',
 '0932548791', 'W008', 'Dang giao hang'),  
('P009', 40000.00, 'Nguoi nhan', 'Quang Ninh', 'Cam Pha', 'Cam Thanh',
 'So 17 Cam Thanh', 'Ly Khac Duong', 'Hai Duong', 'Thanh Mien', 'Hop Duc',
 'So 108 Hop Duc', '0923154789', 'W006', 'Da giao hang'),
('P010', 78000.00, 'Nguoi gui', 'Ha Noi', 'Thanh Xuan', 'Khuong Trung',
 'So 123 Khuong Trung', 'Tran Thi Thanh Thao', 'Nghe An', 'Vinh', 'Hung Dung',
 'So 20 Hung Dung', '0912548796', 'W002', 'Dang xu ly'),
('P011', 30000.00, 'Nguoi gui', 'TP. Ho Chi Minh', 'Go Vap', 'Phường Phú Nhuận', 
'185 Hùng Vương', 'Nguyen Hoang Phuc', 'Binh Duong', 'Thu Dau Mot', 'Phu Cuong',
 'So 48 Phu Cuong','0945781234', 'W011', 'Dang giao hang'),
('P012', 40000.00, 'Nguoi nhan', 'Quang Binh', 'Dong Hoi', 'Hai Thanh',
 'So 233 Hai Thanh', 'Hoang Anh Xuan', 'Da Nang', 'Ngu Hanh Son', 'My An',
 'So 94 My An', '0953124789', 'W005', 'Da giao hang'),
('P013', 25000.00, 'Nguoi gui', 'Hai Phong', 'Kien An', 'Ngoc Son',
 'So 19 Ngoc Son', 'Nguyen Thi Bich', 'Bac Ninh', 'Tu Son', 'Dong Ngan',
 'So 26 Dong Ngan', '0962145789', 'W009', 'Dang xu ly'),
('P014', 25000.00, 'Nguoi nhan', 'Thai Nguyen', 'Thanh pho Thai Nguyen', 'Phuong Quang Vinh',
 '449 Duong Quang Trung', 'Le Van Khuong', 'Vinh Phuc', 'Phuc Yen', 'Xuan Hoa',
 'So 122 Xuan Hoa', '0914785236', 'W006', 'Dang giao hang'),
('P015', 289000.00, 'Nguoi gui', 'TP. Ho Chi Minh', 'Go Vap', 'Phường Phú Nhuận', 
'185 Hùng Vương', 'Pham Thi Duong', 'Lang Son', 'Lang Son', 'Hoang Van Thu',
 'So 51 Hoang Van Thu', '0924587123', 'W013', 'Da giao hang'),
('P016', 44000.00, 'Nguoi gui', 'Binh Dinh', 'Quy Nhon', 'Ly Thuong Kiet',
 'So 251 Ly Thuong Kiet', 'Tran Thi Chinh', 'Da Nang', 'Hai Chau', 'Thuan Phuoc',
 'So 011 Thuan Phuoc', '0932478591', 'W002', 'Dang xu ly'),
('P017', 120000.00, 'Nguoi nhan', 'Nam Dinh', 'Nam Truc', 'Truc Hung',
 'So 154 Truc Hung', 'Vu Van Vuong', 'Hai Phong', 'Hong Bang', 'Hoang Van Thu',
 'So 18 Hoang Van Thu', '0942154789', 'W011', 'Dang giao hang'),
('P018', 66000.00, 'Nguoi gui', 'Ha Noi', 'Ba Dinh', 'Ngoc Ha',
 'So 46 Ngoc Ha', 'Le Thi Huyen', 'Ha Tinh', 'Hong Linh', 'Trung Luong',
 'So 08 Trung Luong', '0915784236', 'W015', 'Da giao hang'),
('P019', 78000.00, 'Nguoi nhan', 'TP. Ho Chi Minh', 'Quan 4', 'Phuong 6',
 'So 98 Phuong 6', 'Nguyen Van Duc', 'Quang Ngai', 'Son Tinh', 'Tinh Son',
 'So 233 Tinh Son', '0954781234', 'W001', 'Dang xu ly'),
('P020', 140000.00, 'Nguoi gui', 'Da Nang', 'Thanh Khe', 'Hoa Khanh Bac',
 'So 41 Hoa Khanh Bac', 'Tran Hoang Hien', 'Gia Lai', 'Pleiku', 'Chu Se',
 'So 188 Chu Se', '0925781234', 'W012', 'Dang giao hang');
select * from product
order by OrderID asc;
#Cái dưới này để nếu sai thì xóa nhập lại thui
delete from product
where OrderID like "P%";





















