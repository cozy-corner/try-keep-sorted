-- 部分的にkeep-sortedを適用する例
-- PK、メタデータは固定位置、ビジネスカラムだけソート

CREATE TABLE users (
  user_id BIGINT PRIMARY KEY AUTO_INCREMENT,

  -- ビジネスカラム（この部分だけソート）
  -- keep-sorted start
  age INT,
  email VARCHAR(100) UNIQUE NOT NULL,
  status VARCHAR(20) DEFAULT 'active',
  username VARCHAR(50) NOT NULL,
  -- keep-sorted end

  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
