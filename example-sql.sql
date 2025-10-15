-- Example 1: Basic column sorting
CREATE TABLE users (
  -- keep-sorted start
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  email VARCHAR(100) UNIQUE NOT NULL,
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  status VARCHAR(20) DEFAULT 'active',
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  username VARCHAR(50) NOT NULL,
  -- keep-sorted end
);

-- Example 2: Sorting with prefix_order (id first, timestamps last)
CREATE TABLE products (
  -- keep-sorted start prefix_order=id,name,,created_at,updated_at
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(200) NOT NULL,
  category VARCHAR(50),
  description TEXT,
  price DECIMAL(10, 2) NOT NULL,
  stock_quantity INT DEFAULT 0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  -- keep-sorted end
);

-- Example 3: Index definitions
-- keep-sorted start
CREATE INDEX idx_products_category ON products(category);
CREATE INDEX idx_products_name ON products(name);
CREATE INDEX idx_users_created_at ON users(created_at);
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_status ON users(status);
-- keep-sorted end
