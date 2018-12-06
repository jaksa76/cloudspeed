FROM openjdk:10-jdk
ADD ./target/springboot-1.2-SNAPSHOT.jar /usr/springboot-1.2-SNAPSHOT.jar
EXPOSE 5000
ENTRYPOINT ["java", "-jar", "/usr/springboot-1.2-SNAPSHOT.jar"]