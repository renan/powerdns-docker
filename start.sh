#!/usr/bin/env bash

# Give time to database to boot up
sleep 10

# Import schema structure
if [ -e "pdns.sql" ]; then
	mysql --host=database --user=$MYSQL_USER --password=$MYSQL_PASSWORD --database=$MYSQL_DATABASE < pdns.sql
	rm pdns.sql
	echo "Imported schema structured"
fi

/usr/sbin/pdns_server \
	--launch=gmysql --gmysql-host=database --gmysql-user=$MYSQL_USER --gmysql-dbname=$MYSQL_DATABASE --gmysql-password=$MYSQL_PASSWORD \
	--webserver=yes --webserver-address=0.0.0.0 --webserver-port=80 \
	--experimental-json-interface=yes --experimental-api-key=changeme
