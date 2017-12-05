-- bounties.sql

DROP TABLE IF EXISTS bounties;

CREATE TABLE bounties (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  bounty_value INT2,
  favourite_weapon VARCHAR(255),
  collected_by VARCHAR(255)
);

-- bounties.sql
