-- DDL generated by Postico 1.5.20
-- Not all database features are supported. Do not use for backup.

-- Table Definition ----------------------------------------------

CREATE TABLE IF NOT EXISTS universal_profiles (
    id text PRIMARY KEY,
    profile_image_url text,
    name text,
    description text
);


CREATE TABLE IF NOT EXISTS users(
  id VARCHAR(69) PRIMARY KEY,
  balance NUMERIC(27,18) DEFAULT 0,
  prestige SMALLINT DEFAULT 0,
  biography VARCHAR(666) DEFAULT NULL,
  creation_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  current_login_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  last_login_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS nft(
  id BIGSERIAL PRIMARY KEY,
  lsp7 VARCHAR(42) DEFAULT NULL,
  owner VARCHAR(69) REFERENCES users,
  name VARCHAR(256) DEFAULT NULL,
  description VARCHAR(2048) DEFAULT NULL,
  price NUMERIC(27,18) DEFAULT 0,
  status VARCHAR(13) DEFAULT 'ACTIVE',
  creation_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  preview_of BIGINT REFERENCES nft DEFAULT NULL,
  last_edit_time TIMESTAMP DEFAULT NULL,
  UNIQUE (owner, name),
  UNIQUE (preview_of)
);

CREATE TABLE IF NOT EXISTS file(
  hash VARCHAR(69) PRIMARY KEY,
  ipfs VARCHAR(46) DEFAULT NULL,
  path VARCHAR(256),
  size INTEGER,
  type_general CHAR(1) DEFAULT NULL,
  creation_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS file_nft(
  nft_id BIGINT REFERENCES nft,
  file_hash VARCHAR(69) REFERENCES file,
  status VARCHAR(13) DEFAULT 'ACTIVE',
  file_name VARCHAR(256),
  PRIMARY KEY (nft_id, file_hash)
);

CREATE TABLE IF NOT EXISTS purchase(
  user_id VARCHAR(69) REFERENCES users,
  nft_id BIGINT REFERENCES nft,
  purchase_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  price NUMERIC(27,18),
  honesty_feedback SMALLINT DEFAULT -1,
  quality_feedback SMALLINT DEFAULT -1,
  PRIMARY KEY (user_id, nft_id)
);

CREATE TABLE IF NOT EXISTS acquire(
  user_id VARCHAR(69) REFERENCES users,
  file_hash VARCHAR(69) REFERENCES file,
  release_time TIMESTAMP,
  download_count INTEGER DEFAULT 1
);

CREATE TABLE IF NOT EXISTS announcement(
  id SERIAL PRIMARY KEY,
  creation_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  title VARCHAR(256),
  html TEXT
);

CREATE TABLE IF NOT EXISTS trophy(
  user_id VARCHAR(69) REFERENCES users,
  name VARCHAR(69),
  level SMALLINT DEFAULT 0,
  PRIMARY KEY (user_id, name)
);

CREATE TABLE IF NOT EXISTS config(
  env VARCHAR(13),
  type VARCHAR(13) DEFAULT 'STR',
  key VARCHAR(69),
  value VARCHAR(2048),
  PRIMARY KEY (env, key)
);

CREATE TABLE IF NOT EXISTS nft_edit_history(
  nft_id BIGINT REFERENCES nft,
  edit_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  reason VARCHAR(2048) DEFAULT NULL,
  previous_name VARCHAR(256),
  previous_description VARCHAR(2048),
  previous_price NUMERIC(27,18)
);

CREATE TABLE IF NOT EXISTS misc_tx(
  id BIGSERIAL PRIMARY KEY,
  user_id VARCHAR(69) REFERENCES users,
  transaction_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  transaction_type VARCHAR(69),
  amount NUMERIC(27,18),
  payload JSONB
);
