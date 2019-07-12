FROM gradle:jdk10 as builder

WORKDIR /home/gradle/src
RUN ls -lha
RUN wget https://github.com/drigoangelo/voicecontroller/archive/1.0.0.tar.gz
RUN ls -lha
RUN tar -zxvf 1.0.0.tar.gz
RUN ls -lha
RUN rm 1.0.0.tar.gz
RUN ls -lha
RUN gradle bootJar
RUN ls -lah

FROM adoptopenjdk:11-jre-hotspot
EXPOSE 8080

COPY --from=builder /home/gradle/src/voicecontroller-1.0.0/build/libs/voicecontroller-1.0.0.jar /app/voicecontroller-1.0.0.jar
WORKDIR /app

ENV JAVA_OPTS=""
ENTRYPOINT [ "sh", "-c", "java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar /app/voicecontroller-1.0.0.jar" ]
