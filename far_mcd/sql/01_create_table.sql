CREATE EXTENSION IF NOT EXISTS postgis;

-- 住所のテーブル

CREATE TABLE mlit (
  id TEXT PRIMARY KEY, -- ID 住所コード
  name TEXT, -- 住所
  geom GEOMETRY(POINT, 4326) -- JGD2000 to WGS84
);

CREATE INDEX ix_mlit ON mlit USING GiST (geom);

-- マックのテーブル

CREATE TABLE mcd (
  id TEXT PRIMARY KEY, -- 店舗key
  name TEXT, -- 店名＋住所
  geom GEOMETRY(POINT, 4326) -- WGS84
);

CREATE INDEX ix_mcd ON mcd USING GiST (geom);
