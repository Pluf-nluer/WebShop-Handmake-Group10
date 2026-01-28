# Giai đoạn 1: Build bằng Maven (trỏ vào thư mục backend)
FROM maven:3.8.4-openjdk-11 AS build
COPY backend /app
WORKDIR /app
RUN mvn clean package -DskipTests

# Giai đoạn 2: Chạy bằng Tomcat
FROM tomcat:9.0-jdk11-openjdk
# Copy file war vừa build xong vào Tomcat
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]
