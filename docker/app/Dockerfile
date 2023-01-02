FROM jdk
RUN mkdir -p /opt/app

COPY ../../../../tmp/spring-petclinic-2.7.3.jar /opt/app/spring-petclinic-2.7.3.jar
RUN cat src/main/resources/application.properties src/main/resources/application-postgres.properties >> /opt/app/application.properties

ADD script/run.sh /opt/app/run.sh
RUN chmod +x /opt/app/run.sh

WORKDIR /opt/app

CMD ["./run.sh"]