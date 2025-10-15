-- 理想的な順序:
-- 1. id (主キー)
-- 2. ビジネスカラム (name, email, status, price など)
-- 3. メタデータ (created_at, updated_at, deleted_at)

CREATE TABLE users (
  -- keep-sorted start prefix_order=id,,created_at,updated_at,deleted_at
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  email VARCHAR(100) UNIQUE NOT NULL,
  profile_image_url VARCHAR(255),
  status VARCHAR(20) DEFAULT 'active',
  username VARCHAR(50) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted_at TIMESTAMP NULL,
  -- keep-sorted end
);

-- さらに細かく: id -> name系 -> その他ビジネスロジック -> メタデータ
CREATE TABLE products (
  -- keep-sorted start prefix_order=id,name,description,,created_at,updated_at,deleted_at
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(200) NOT NULL,
  name_en VARCHAR(200),
  name_ja VARCHAR(200),
  description TEXT,
  description_en TEXT,
  description_ja TEXT,
  category VARCHAR(50),
  price DECIMAL(10, 2) NOT NULL,
  sku VARCHAR(50) UNIQUE,
  stock_quantity INT DEFAULT 0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted_at TIMESTAMP NULL,
  -- keep-sorted end
);
