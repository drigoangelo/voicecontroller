FROM gradle:jdk11 as builder
WORKDIR /home/gradle/
RUN mkdir src
WORKDIR /home/gradle/src
RUN wget https://github.com/drigoangelo/voicecontroller/archive/1.0.0.tar.gz
RUN tar -zxvf 1.0.0.tar.gz
RUN rm 1.0.0.tar.gz
WORKDIR /home/gradle/src/voicecontroller-1.0.0
RUN gradle bootJar

FROM adoptopenjdk:11-jre-hotspot
EXPOSE 8080

COPY --from=builder /home/gradle/src/voicecontroller-1.0.0/build/libs/voicecontroller-1.0.0.jar /app/voicecontroller-1.0.0.jar
WORKDIR /app

ENV JAVA_OPTS=""
ENTRYPOINT [ "sh", "-c", "java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar /app/voicecontroller-1.0.0.jar" ]
