FROM elasticsearch:1
COPY plugins/java-stacktrace-nomalizer-1.0-SNAPSHOT.jar /tmp/
RUN plugin -i java-stacktrace-normalizer -url file:///tmp/java-stacktrace-nomalizer-1.0-SNAPSHOT.jar
ENTRYPOINT 
CMD elasticsearch
