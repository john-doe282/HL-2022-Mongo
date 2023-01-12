RIDES_FILE=data/rides.csv

if ! [ -f "$RIDES_FILE" ]; then
	echo "Generating rides data"
	python_3 generate_rides.py data/London_postcodes.csv --out data/rides.csv
else
	echo "Using existing rides data"
fi

docker-compose up -d

until docker ps | grep -q 'mongo-config-02'; do
  sleep 1;
done

sh init_rs.sh
sleep 15
docker-compose exec router01 sh -c "mongo < /scripts/init-router.js"
sleep 15
sh import_and_query_data.sh

docker-compose down -v --remove-orphans