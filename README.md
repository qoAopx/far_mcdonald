# 日本一マクドナルドから遠い場所はPostGISで求められるかな？

- ...を試したプログラム

## 使い方

- PostGISを起動します。

```sh
$ create_data.sh
$ cd far_mcd
$ docker-compose up
```

### 検索SQL

```sql
WITH MIN_DIST AS (
SELECT mlit.id AS id ,min(ST_DISTANCE(mcd.geom,mlit.geom)) AS dist FROM mlit,mcd
GROUP BY mlit.id
ORDER BY dist DESC
LIMIT 30
)
SELECT mlit.id,mlit.name,ST_AsText(ST_Transform(geom,4326)) FROM mlit 
INNER JOIN MIN_DIST ON mlit.id = MIN_DIST.id;
```