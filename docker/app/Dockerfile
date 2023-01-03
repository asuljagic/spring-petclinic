FROM jdk
RUN mkdir -p /opt/app && apt-get update && apt-get install -y jq

ADD ./tmp/spring-petclinic-2.7.3.jar /opt/app/spring-petclinic-2.7.3.jar
ADD ./tmp/application.properties /opt/app/application.properties

ADD run.sh /opt/app/run.sh
RUN chmod +x /opt/app/run.sh

WORKDIR /opt/app

CMD ["./run.sh"]