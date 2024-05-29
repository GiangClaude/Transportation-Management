-- Tạo bảng roles
CREATE TABLE roles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

-- Tạo bảng permissions
CREATE TABLE permissions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- Thêm các vai trò vào bảng roles
INSERT INTO roles (name) VALUES 
('Sender'),
('Shipper'),
('Revenue Manager'),
('Customer Manager'),
('Receiver');

-- Thêm các quyền vào bảng permissions
INSERT INTO permissions (name) VALUES 
('Create Order'),
('View Order Information'),
('View Shipper Information'),
('View Financial Report'),
('Create Receiver Address'),
('View Sender Address'),
('View Order Code Information');

-- Tạo bảng role_permissions để liên kết vai trò và quyền
CREATE TABLE role_permissions (
    role_id INT,
    permission_id INT,
    FOREIGN KEY (role_id) REFERENCES roles(id),
    FOREIGN KEY (permission_id) REFERENCES permissions(id)
);

-- Gán các quyền cho các vai trò

-- Permissions for Sender
INSERT INTO role_permissions (role_id, permission_id) 
VALUES 
((SELECT id FROM roles WHERE name = 'Sender'), (SELECT id FROM permissions WHERE name = 'Create Order')),
((SELECT id FROM roles WHERE name = 'Sender'), (SELECT id FROM permissions WHERE name = 'View Order Information')),
((SELECT id FROM roles WHERE name = 'Sender'), (SELECT id FROM permissions WHERE name = 'View Shipper Information')),
((SELECT id FROM roles WHERE name = 'Sender'), (SELECT id FROM permissions WHERE name = 'View Financial Report')),
((SELECT id FROM roles WHERE name = 'Sender'), (SELECT id FROM permissions WHERE name = 'Create Receiver Address')),
((SELECT id FROM roles WHERE name = 'Sender'), (SELECT id FROM permissions WHERE name = 'View Sender Address'));

-- Permissions for Shipper
INSERT INTO role_permissions (role_id, permission_id) 
VALUES 
((SELECT id FROM roles WHERE name = 'Shipper'), (SELECT id FROM permissions WHERE name = 'View Order Information')),
((SELECT id FROM roles WHERE name = 'Shipper'), (SELECT id FROM permissions WHERE name = 'View Shipper Information'));

-- Permissions for Revenue Manager
INSERT INTO role_permissions (role_id, permission_id) 
VALUES 
((SELECT id FROM roles WHERE name = 'Revenue Manager'), (SELECT id FROM permissions WHERE name = 'View Financial Report'));

-- Permissions for Customer Manager
INSERT INTO role_permissions (role_id, permission_id) 
VALUES 
((SELECT id FROM roles WHERE name = 'Customer Manager'), (SELECT id FROM permissions WHERE name = 'Create Receiver Address')),
((SELECT id FROM roles WHERE name = 'Customer Manager'), (SELECT id FROM permissions WHERE name = 'View Sender Address'));

-- Permissions for Receiver (without an account)
INSERT INTO role_permissions (role_id, permission_id) 
VALUES 
((SELECT id FROM roles WHERE name = 'Receiver'), (SELECT id FROM permissions WHERE name = 'View Order Code Information'));

-- Tạo bảng users và user_roles để lưu thông tin người dùng và gán vai trò cho họ

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    password VARCHAR(100) NOT NULL -- hoặc phương pháp băm mật khẩu khác
);

CREATE TABLE user_roles (
    user_id INT,
    role_id INT,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (role_id) REFERENCES roles(id)
);

-- Thêm người dùng và gán vai trò cho họ

-- Adding users
INSERT INTO users (username, password) VALUES 
('sender_user', 'hashed_password1'),
('shipper_user', 'hashed_password2'),
('revenue_manager_user', 'hashed_password3'),
('customer_manager_user', 'hashed_password4');

-- Assigning roles to users
INSERT INTO user_roles (user_id, role_id) 
VALUES 
((SELECT id FROM users WHERE username = 'sender_user'), (SELECT id FROM roles WHERE name = 'Sender')),
((SELECT id FROM users WHERE username = 'shipper_user'), (SELECT id FROM roles WHERE name = 'Shipper')),
((SELECT id FROM users WHERE username = 'revenue_manager_user'), (SELECT id FROM roles WHERE name = 'Revenue Manager')),
((SELECT id FROM users WHERE username = 'customer_manager_user'), (SELECT id FROM roles WHERE name = 'Customer Manager'));
