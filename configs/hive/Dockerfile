FROM apache/hive:3.1.3

# Install necessary packages
USER root
RUN apt-get update && apt-get install -y wget tar

# Download and install Apache Tez
RUN wget https://archive.apache.org/dist/tez/0.9.2/apache-tez-0.9.2-bin.tar.gz && \
    tar -xzf apache-tez-0.9.2-bin.tar.gz && \
    mv apache-tez-0.9.2-bin /opt/tez && \
    rm apache-tez-0.9.2-bin.tar.gz

# Set the Tez configuration
ENV TEZ_HOME=/opt/tez
ENV HADOOP_CLASSPATH=$HADOOP_CLASSPATH:/opt/tez/*:/opt/tez/lib/*

# Ensure the tez jars are available for hive
RUN mkdir -p /opt/hive/lib/ && \
    cp /opt/tez/*.jar /opt/hive/lib/ && \
    cp /opt/tez/lib/*.jar /opt/hive/lib/

# Download additional libraries
RUN wget https://jdbc.postgresql.org/download/postgresql-42.7.4.jar -P /opt/hive/lib/
RUN wget https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/3.1.3/hadoop-aws-3.1.3.jar -P /opt/hive/lib/
RUN wget https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-bundle/1.11.271/aws-java-sdk-bundle-1.11.271.jar -P /opt/hive/lib/

# Fixing incompatible guava versions
RUN rm -rf /opt/hive/lib/guava-*.jar
RUN wget https://repo1.maven.org/maven2/com/google/guava/guava/27.0-jre/guava-27.0-jre.jar -P /opt/hive/lib/

USER hive
