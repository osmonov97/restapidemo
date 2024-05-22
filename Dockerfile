FROM openjdk:17-alpine AS builder

COPY gradlew .
COPY gradle gradle
COPY build.gradle  .
COPY settings.gradle .
COPY src src
RUN chmod +x ./gradlew
RUN ./gradlew bootJar

FROM openjdk:17-alpine
COPY --from=builder build/libs/*.jar restapidemo.jar

EXPOSE 8080

ENTRYPOINT [ "java" , "-jar" , "restapidemo.jar" ]
