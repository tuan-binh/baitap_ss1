-- Tạo database và sử dụng nó
CREATE DATABASE quanlybanhang_demo;
USE quanlybanhang_demo;

-- Tạo bảng Category
CREATE TABLE Category (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  createDate DATETIME DEFAULT NOW(),
  status TINYINT DEFAULT 1
);

-- Tạo bảng Product
CREATE TABLE Product (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  price FLOAT,
  image TEXT,
  quantity INT CHECK(quantity >= 0),
  title TEXT,
  createdDate DATETIME DEFAULT NOW(),
  category_id INT REFERENCES Category(id),
  status TINYINT DEFAULT 1
);

-- Tạo bảng Address
CREATE TABLE Address (
  id INT AUTO_INCREMENT PRIMARY KEY,
  `add` VARCHAR(255) NOT NULL,
  nameReceiver VARCHAR(255),
  phoneNumber VARCHAR(100) NOT NULL
);

-- Tạo bảng User
CREATE TABLE `User` (
  id INT AUTO_INCREMENT PRIMARY KEY,
  fullname VARCHAR(255),
  username VARCHAR(255) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  role TINYINT DEFAULT 1,
  status TINYINT DEFAULT 1,
  address_id INT REFERENCES Address(id)
);

-- Tạo bảng Order
CREATE TABLE `Order` (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL REFERENCES `User`(id),
  total FLOAT,
  createdDate DATETIME DEFAULT NOW(),
  status TINYINT DEFAULT 1,
  `type` TINYINT DEFAULT 1
);

-- Tạo bảng Order_detail
CREATE TABLE Order_detail (
  id INT AUTO_INCREMENT PRIMARY KEY,
  order_id INT NOT NULL REFERENCES `Order`(id),
  product_id INT REFERENCES product(id),
  productName VARCHAR(255),
  productPrice FLOAT,
  quantity INT CHECK(quantity > 0)
);
ALTER TABLE Product
DROP COLUMN image;

-- Xóa cột 'title' từ bảng 'Product'
ALTER TABLE Product
DROP COLUMN title;

-- Insert dữ liệu mẫu vào các bảng

-- Thêm dữ liệu vào bảng Category
INSERT INTO category (name) VALUES
("Quần"),("Áo"),("Mũ"),("Giày dép"),("Trang Sức");

-- Thêm dữ liệu vào bảng Address
INSERT INTO address (`add`, nameReceiver, phoneNumber) VALUES
("Hà nội", "Nguyễn văn A", "0987736533"),
("Hà Nam", "Nguyễn văn B", "09877362333"),
("Nghệ An", "Nguyễn văn C", "0987474533"),
("Bến Tre", "Nguyễn văn D", "0987982333");

-- Thêm dữ liệu vào bảng User
INSERT INTO `user` (fullname, username, password, address_id) VALUES
("Xuân Hùng", "hunghx", "123456", 1),
("Tuân Anh", "anhht", "123456", 2),
("Đức Minh", "minhkun", "123456", 3),
("Thị Ngân", "ngantx", "123456", 4);

-- Thêm dữ liệu vào bảng Order
INSERT INTO `order` (user_id, total) VALUES
(1, 1000000), -- Đơn hàng 1 của người dùng có id = 1, tổng tiền = 1.000.000
(2, 750000), -- Đơn hàng 2 của người dùng có id = 2, tổng tiền = 750.000
(3, 500000), -- Đơn hàng 3 của người dùng có id = 3, tổng tiền = 500.000
(4, 900000); -- Đơn hàng 4 của người dùng có id = 4, tổng tiền = 900.000

-- Thêm dữ liệu vào bảng Product
INSERT INTO product (name, price, quantity, category_id) VALUES
("Quần âu nam", 150000, 10, 1),
("Quần jean", 350000, 15, 1),
("Áo dài", 550000, 20, 2),
("Mũ lưỡi trai", 200000, 25, 3),
("Áo dạ nữ", 650000, 30, 2),
("Áo sơ mi", 250000, 35, 2),
("Mũ bảo hiểm", 450000, 40, 3),
("Giày nike", 950000, 45, 4),
("Nhẫn kim cương", 11150000, 50, 5),
("Giày adidas", 2150000, 55, 4);

-- Thêm dữ liệu vào bảng Order_detail
INSERT INTO order_detail (order_id, product_id, productName, productPrice, quantity) VALUES
(1, 1, "Quần âu nam", 150000, 2),
(1, 3, "Áo dài", 550000, 5),
(1, 4, "Mũ lưỡi trai", 200000, 10),
(2, 1, "Quần âu nam", 150000, 4),
(2, 5, "Áo dạ nữ", 650000, 1),
(2, 7, "Mũ bảo hiểm", 450000, 5),
(3, 1, "Quần âu nam", 150000, 6),
(3, 8, "Giày nike", 950000, 3),
(3, 10, "Giày adidas", 2150000, 2),
(3, 9, "Nhẫn kim cương", 11150000, 5),
(4, 1, "Quần âu nam", 150000, 6),
(4, 3, "Áo dài", 550000, 2),
(4, 5, "Áo dạ nữ", 650000, 3);

-- Hiển thị dữ liệu trong các bảng

SELECT * FROM Category;
SELECT * FROM Product;
SELECT * FROM Address;
SELECT * FROM `User`;
SELECT * FROM `Order`;
SELECT * FROM Order_detail;
-- Liệt kê thông tin đơn hàng bao gồm id, ngày tạo (ngayTao), tên người dùng (fullname) và tổng tiền (total) của mỗi đơn hàng.
SELECT `Order`.id, `Order`.createdDate AS ngayTao, `User`.fullname AS hoTen, `Order`.total AS tongTien
FROM `Order`
LEFT JOIN `User` ON `Order`.user_id = `User`.id;

-- Liệt kê thông tin đơn hàng bao gồm id, ngày tạo (ngayTao), tên người dùng (fullname) và tổng tiền (total) của mỗi đơn hàng có trạng thái (status) là 1.
SELECT `Order`.id, `Order`.createdDate AS ngayTao, `User`.fullname AS hoTen, `Order`.total AS tongTien
FROM `Order`
LEFT JOIN `User` ON `Order`.user_id = `User`.id
WHERE `Order`.status = 1;

-- Liệt kê thông tin đơn hàng bao gồm id, ngày tạo (ngayTao), tên người dùng (fullname), số lượng sản phẩm đã mua và tổng tiền (total) của mỗi đơn hàng có trạng thái (status) là 1.
SELECT `Order`.id, `Order`.createdDate AS ngayTao, `User`.fullname AS hoTen, SUM(Order_detail.quantity) AS soLuong, `Order`.total AS tongTien
FROM `Order`
LEFT JOIN `User` ON `Order`.user_id = `User`.id
LEFT JOIN Order_detail ON `Order`.id = Order_detail.order_id
WHERE `Order`.status = 1
GROUP BY `Order`.id;

-- Liệt kê thông tin chi tiết đơn hàng bao gồm id, tên sản phẩm, số lượng đã mua và giá sản phẩm (productPrice) của mỗi sản phẩm trong từng đơn hàng.
SELECT Order_detail.id, Product.name AS ten, Order_detail.quantity AS soLuong, Product.price AS giaSanPham
FROM Order_detail
LEFT JOIN Product ON Order_detail.product_id = Product.id;

-- Liệt kê tên và địa chỉ người nhận (nameReceiver) của tất cả các đơn hàng.
SELECT `Order`.id, Address.nameReceiver AS tenNguoiNhan, Address.add AS diaChi
FROM `Order`
LEFT JOIN `User` ON `Order`.user_id = `User`.id
LEFT JOIN Address ON `User`.address_id = Address.id;

-- Liệt kê tên sản phẩm và số lượng mua của mỗi đơn hàng (ghi chú: giá sản phẩm được lưu trong bảng Product).
SELECT `Order`.id, Product.name AS ten, Order_detail.quantity AS soLuong
FROM `Order`
LEFT JOIN Order_detail ON `Order`.id = Order_detail.order_id
LEFT JOIN Product ON Order_detail.product_id = Product.id;

-- Liệt kê thông tin đơn hàng bao gồm id, ngày tạo (ngayTao), tổng tiền (total), và số lượng sản phẩm đã mua trong mỗi đơn hàng.
SELECT `Order`.id, `Order`.createdDate AS ngayTao, `Order`.total, SUM(Order_detail.quantity) AS soLuongMua
FROM `Order`
LEFT JOIN Order_detail ON `Order`.id = Order_detail.order_id
GROUP BY `Order`.id;

-- Liệt kê tên người dùng, tên sản phẩm và số lượng đã mua của mỗi đơn hàng có loại (type) là 1.
SELECT `User`.fullname AS hoTen, Product.name AS ten, Order_detail.quantity AS soLuong
FROM `Order`
LEFT JOIN `User` ON `Order`.user_id = `User`.id
LEFT JOIN Order_detail ON `Order`.id = Order_detail.order_id
LEFT JOIN Product ON Order_detail.product_id = Product.id
WHERE `Order`.`type` = 1;

-- Liệt kê tên người dùng, tên sản phẩm và số lượng đã mua của mỗi đơn hàng có loại (type) là 2.
SELECT `User`.fullname AS hoTen, Product.name AS ten, Order_detail.quantity AS soLuong
FROM `Order`
LEFT JOIN `User` ON `Order`.user_id = `User`.id
LEFT JOIN Order_detail ON `Order`.id = Order_detail.order_id
LEFT JOIN Product ON Order_detail.product_id = Product.id
WHERE `Order`.`type` = 2;

-- Liệt kê tổng tiền (total) của tất cả các đơn hàng được đặt bởi người dùng có vai trò (role) là 1.
SELECT SUM(`Order`.total) AS tongTien
FROM `Order`
LEFT JOIN `User` ON `Order`.user_id = `User`.id
WHERE `User`.role = 1;

-- Liệt kê thông tin của tất cả các đơn hàng được đặt bởi người dùng có tên đăng nhập (username) là 'hunghx'.
SELECT `Order`.id, `Order`.createdDate AS ngayTao, `Order`.total, `User`.username AS tenDangNhap
FROM `Order`
LEFT JOIN `User` ON `Order`.user_id = `User`.id
WHERE `User`.username = 'hunghx';

-- Liệt kê tên sản phẩm và số lượng đã mua của mỗi đơn hàng được đặt bởi người dùng có tên đăng nhập (username) là 'hunghx'.
SELECT Product.name AS ten, Order_detail.quantity
FROM `Order`
LEFT JOIN `User` ON `Order`.user_id = `User`.id
LEFT JOIN Order_detail ON `Order`.id = Order_detail.order_id
LEFT JOIN Product ON Order_detail.product_id = Product.id
WHERE `User`.username = 'hunghx';

-- Liệt kê thông tin của các sản phẩm thuộc danh mục 'Áo' (từ bảng Category) và có số lượng còn lại (quantity) lớn hơn 5.
SELECT Product.name AS ten, Product.quantity AS soLuong
FROM Product
LEFT JOIN Category ON Product.category_id = Category.id
WHERE Category.name = 'Áo' AND Product.quantity > 5;

-- Liệt kê tên sản phẩm và số lượng đã mua của mỗi đơn hàng (ghi chú: giá sản phẩm được lưu trong bảng Product) có tổng tiền (total) lớn hơn 1.000.000.
SELECT Product.name AS ten, Order_detail.quantity AS soLuong
FROM `Order`
LEFT JOIN Order_detail ON `Order`.id = Order_detail.order_id
LEFT JOIN Product ON Order_detail.product_id = Product.id
WHERE `Order`.total > 1000000;
-- Xóa cột 'image' từ bảng 'Product'
