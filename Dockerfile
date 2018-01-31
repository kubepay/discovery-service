FROM openjdk:8-jre-alpine
MAINTAINER Abhishek Pandey <abhiesa@outlook.com>

ADD ./target/discovery-service.jar /app/
CMD ["java", "-Xmx200m", "-jar", "/app/discovery-service.jar"]


HEALTHCHECK --interval=10s --timeout=3s CMD curl -f http://localhost:8888/health || exit 1
EXPOSE 8761