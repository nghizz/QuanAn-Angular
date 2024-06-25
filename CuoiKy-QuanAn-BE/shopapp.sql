create database Shopapp;

use Shopapp;

--Bảng users của khách hàng
create table users(
    id INT PRIMARY KEY auto_increment,
    fullname NVARCHAR(100) DEFAULT '',
    phone_number VARCHAR(10) NOT NULL,
    address VARCHAR(200) DEFAULT '',
    password VARCHAR(50) NOT NULL DEFAULT '',
    create_at DATETIME,
    update_at DATETIME,
    is_active tinyint DEFAULT 1,
    google_account_id INT DEFAULT 0
);

--Cập nhật thêm role_id
ALTER TABLE
    users
ADD
    COLUMN role_id int;

--Bảng role: Admin và Users
CREATE TABLE roles(
    id INT PRIMARY KEY,
    name VARCHAR(20) NOT NULL
);

--thiết lập liên kết bảng
ALTER TABLE
    users
ADD
    FOREIGN KEY (role_id) REFERENCES roles(id);

--Bảng token -- giải thích: xác nhận lần đăng nhập tiếp theo
CREATE TABLE tokens(
    id INT PRIMARY KEY auto_increment,
    token VARCHAR(255) UNIQUE NOT NULL,
    token_type VARCHAR(50) NOT NULL,
    expiration_date DATETIME,
    revoked tinyint(1) NOT NULL,
    expired tinyint(1) NOT NULL,
    user_id int,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

--Tạo bảng đăng nhập từ google
CREATE TABLE social_accounts(
    id INT PRIMARY KEY auto_increment,
    provider VARCHAR(20) NOT NULL COMMENT 'Tên nhà Social Network',
    provider_id VARCHAR(50) NOT NULL,
    email VARCHAR(150) NOT NULL COMMENT 'Email Tài Khoản',
    name VARCHAR(100) NOT NULL COMMENT 'Tên Người Dùng',
    user_id int,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

--Bảng danh mục đồ ăn
CREATE TABLE categories(
    id INT PRIMARY KEY auto_increment,
    name VARCHAR(100) NOT NULL DEFAULT '' COMMENT 'Tên danh mục, vd:Đồ ăn nhanh,...'
);

--Bảng sản phẩm --giải thích: url_img: đường dẫn đến ảnh
CREATE TABLE products(
    id int PRIMARY KEY auto_increment,
    name NVARCHAR(300) COMMENT 'Tên đồ ăn',
    price float NOT NULL check(price >= 0),
    url_img VARCHAR(300) DEFAULT '',
    description LONGTEXT DEFAULT '',
    create_at DATETIME,
    update_at DATETIME,
    category_id int,
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

--Bảng đặt hàng --giải thích status: "cancel", "..." 
-- 1 orders có thể có nhiều order detail
CREATE table orders(
    id int PRIMARY KEY auto_increment,
    user_id int,
    FOREIGN KEY (user_id) REFERENCES users(id),
    fullname VARCHAR(100) DEFAULT '',
    phone_number VARCHAR(20) NOT NULL,
    address NVARCHAR(200) NOT NULL,
    note NVARCHAR(100) DEFAULT '',
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20),
    total_money float check(total_money >= 0)
);

ALTER table
    orders
add
    COLUMN shipping_method VARCHAR(100);

--Phương thức vận chuyển
ALTER table
    orders
add
    COLUMN shipping_address VARCHAR(200);

--Địa chỉ vận chuyển
--xóa 1 đơn hàng => xóa mềm =>>>> thêm trường active nhằm ẩn đi hóa đơn đó
ALTER table
    orders
add
    COLUMN active tinyint(1);

--trạng thái đơn hàng chỉ nhận giá trị cụ thể
ALTER table
    orders
Modify COLUMN status enum('pending', 'processing', 'shipped','delivered','canceles') COMMENT 'Trạng thái đơn hàng'

--TẠO bảng Order detail
CREATE table order_details(
    id int PRIMARY KEY auto_increment,
    order_id int,
    FOREIGN KEY (order_id) REFERENCES orders(id),
    product_id int,
    FOREIGN KEY (product_id) REFERENCES products(id),
    price float check (price >= 0),
    number_of_products int check (number_of_products > 0),
    total_money float check (total_money >= 0),
    color VARCHAR(20) DEFAULT ''
);