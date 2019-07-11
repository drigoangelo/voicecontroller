FROM adoptopenjdk/openjdk11:jdk-11.0.1.13-alpine

VOLUME /tmp

EXPOSE 8080
RUN ./gradlew bootJar
ADD build/libs/voicecontroller-1.0.0.jar /opt/voicecontroller-1.0.0.jar
#RUN sh -c 'touch /opt/voicecontroller.jar'
ENV JAVA_OPTS=""
ENTRYPOINT [ "sh", "-c", "java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar /opt/voicecontroller-1.0.0.jar" ]