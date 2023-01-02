FROM jdk
RUN mkdir -p /opt/app

COPY ./tmp/spring-petclinic-2.7.3.jar /opt/app/spring-petclinic-2.7.3.jar
RUN cat /var/lib/jenkins/workspace/build-app/src/main/resources/application.properties >> opt/app/application.properties && \
    cat /var/lib/jenkins/workspace/build-app/src/main/resources/application-postgres.properties >> /opt/app/application.properties

COPY ./var/lib/jenkins/workspace/build-app/script/run.sh /opt/app/run.sh
RUN chmod +x /opt/app/run.sh

WORKDIR /opt/app

CMD ["./run.sh"]