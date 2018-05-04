import json

f = open('poi_data/poi.json', 'r')
json_dict = json.load(f)
for j in json_dict:
    print(
        'INSERT INTO mcd(id,name,geom) VALUES (\'{}\',\'{}:{}\',ST_GeomFromText(\'POINT({} {})\',4326));'
        .format(j['key'], j['name'], j['address'], j['latitude'], j['longitude']))
