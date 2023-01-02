#!/bin/bash

#fetch config.json and decode it
test=$(printenv CONFIG)
decoded=$(echo "$test" | base64 -d)

#extract the values from config.json
db_host=$(echo $decoded | jq -r '.db_host')
db_port=$(echo $decoded | jq -r '.db_port')
db_user=$(echo $decoded | jq -r '.db_user')
db_pass=$(echo $decoded | jq -r '.db_pass')
db_name=$(echo $decoded | jq -r '.db_name')
#configure jdbc url
jdbc_url="jdbc:postgresql://$db_host:$db_port/$db_name"
#replace the corresponding values
sed -i "s|\${POSTGRES_URL:jdbc:postgresql://localhost/petclinic}|$jdbc_url|" /opt/app/application.properties
sed -i "s|\${POSTGRES_USER:petclinic}|$db_user|" /opt/app/application.properties
sed -i "s|\${POSTGRES_PASS:petclinic}|$db_pass|" /opt/app/application.properties

#ensure java is running as PID 1
exec java -Dspring.config.name=application -Dspring.config.location=file:/opt/app/application.properties -Dspring.profiles.active=postgres -jar /opt/app/spring-petclinic-2.7.3.jar


