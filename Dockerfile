FROM daskdev/dask:latest

RUN apt-get update && \
    apt-get install -y curl unzip fuse && \
    curl -O https://downloads.rclone.org/rclone-current-linux-amd64.zip && \
    unzip rclone-current-linux-amd64.zip && \
    cp rclone-*-linux-amd64/rclone /usr/bin/rclone && \
    chmod +x /usr/bin/rclone && \
    rm -rf rclone*


COPY ./rclone.conf /etc/rclone/rclone.conf

ENV RCLONE_CONFIG=/etc/rclone/rclone.conf

RUN mkdir -p /data/output
WORKDIR /data
