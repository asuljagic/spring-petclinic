FROM ubuntu:20.04
RUN apt-get update && \
    apt-get install -y openjdk-11-jdk && \
    apt-get install -y jq && \
    apt-get clean && \
    rm -rf var/lib/apt/lists/*