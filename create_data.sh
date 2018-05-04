#!/bin/sh -eu

# マクドナルドデータをSQLに変換 北海道限定 離島覗く
python parse_mcd.py | grep '北海道' > ./far_mcd/sql/02_insert_mcd_poi.sql

# 国土交通省のデータをSQLに変換 北海道限定
iconv -f sjis -t utf8 poi_data/01_2016.csv| tail -n +2 | tr -d '"' | \
    awk -F"," '{printf("INSERT INTO mlit(id,name,geom) VALUES (\047%s\047,\047%s%s%s\047,ST_Transform(ST_GeomFromText(\047POINT(%s %s)\047,4612),4326));\n",$5,$2,$4,$6,$7,$8)}' | \
    grep '北海道' | grep -v '奥尻郡奥尻町' | grep -v '羽幌町大字天売' | grep -v '松前郡松前町字大島'> ./far_mcd/sql/03_insert_mlit_poi.sql