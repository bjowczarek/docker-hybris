FROM ubuntu:16.04

# input arguments
ARG COMMERCE_SUITE_FILE
ARG RECIPE

COPY ${COMMERCE_SUITE_FILE} /tmp/hybris-commerce-suite.zip

# Installing prerequisites
RUN \
apt-get update && apt-get -y --no-install-recommends install \
    curl \
    unzip \
    lsof \
    openjdk-8-jre \
    ant

# Setup JAVA_HOME -- useful for docker commandline
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
RUN export JAVA_HOME

ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre/

RUN unzip /tmp/hybris-commerce-suite.zip -d /opt/ \
  && rm /tmp/hybris-commerce-suite.zip \
  && /opt/installer/install.sh -r ${RECIPE}

# Setting entrypoint
COPY entrypoint.sh /opt/entrypoint.sh
RUN chmod +x /opt/entrypoint.sh

ENV ANT_OPTS="-Xmx6144m -XX:MaxPermSize=1536m"
ENV JAVA_OPTIONS='-Xmx6144m'

ENTRYPOINT ["/opt/entrypoint.sh"]
