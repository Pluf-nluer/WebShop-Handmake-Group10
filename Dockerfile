# Giai đoạn build: Dùng JDK 17 thay vì 11
FROM maven:3.8.4-openjdk-17 AS build
COPY backend /app
WORKDIR /app
RUN mvn clean package -DskipTests

# Giai đoạn chạy: Dùng Tomcat phù hợp với Java 17
FROM tomcat:9.0-jdk17-openjdk
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]
