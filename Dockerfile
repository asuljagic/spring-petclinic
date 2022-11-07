FROM maven:3.8-openjdk-11 as build
COPY . .
RUN --mount=type=cache,target=/root/.m2 mvn clean package -Dcheckstyle.skip


FROM openjdk:11.0-jre as development
COPY --from=build target/spring-petclinic-2.7.3.jar spring-petclinic-2.7.3.jar
CMD ["java", "-jar", "-Dspring.profiles.active=postgres","spring-petclinic-2.7.3.jar"]