FROM ubuntu:latest

RUN apt update && \
apt install -y wget && \
cd /usr/bin && \
wget https://github.com/IgnorantGuru/rmdupe/raw/master/rmdupe && \
chmod 755 /usr/bin/rmdupe

ENTRYPOINT ["/usr/bin/rmdupe"]
