FROM jdk
RUN mkdir -p /opt/app

ADD ./tmp/spring-petclinic-2.7.3.jar /opt/app/spring-petclinic-2.7.3.jar
RUN cat spring-petclinic/src/main/resources/application.properties >> opt/app/application.properties && \
    cat spring-petclinic/src/main/resources/application-postgres.properties >> /opt/app/application.properties

ADD run.sh /opt/app/run.sh
RUN chmod +x /opt/app/run.sh

WORKDIR /opt/app

CMD ["./run.sh"]