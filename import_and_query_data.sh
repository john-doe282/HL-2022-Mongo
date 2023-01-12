docker-compose exec router01 sh -c "mongo < /scripts/collection.js"
docker-compose exec router01 sh -c "mongoimport --port 27017 -d taxi -c rides --type csv --file /data/rides.csv --headerline"
docker-compose exec router01 sh -c "mongo < /scripts/query.js"
