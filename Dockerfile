FROM daskdev/dask:latest

# Install dependencies and rclone
RUN apt-get update && \
    apt-get install -y curl unzip fuse nfs-common && \
    curl -O https://downloads.rclone.org/rclone-current-linux-amd64.zip && \
    unzip rclone-current-linux-amd64.zip && \
    cp rclone-*-linux-amd64/rclone /usr/bin/rclone && \
    chmod +x /usr/bin/rclone && \
    rm -rf rclone*

# Create rclone config directory and copy config with proper permissions
RUN mkdir -p /root/.config/rclone && \
    chmod 700 /root/.config/rclone

COPY ./rclone.conf /root/.config/rclone/rclone.conf

# Set rclone config path
ENV RCLONE_CONFIG=/root/.config/rclone/rclone.conf

# (Optional) Create NFS mount point with permissions
RUN mkdir -p /mnt/nfs && chmod 777 /mnt/nfs

# Set default working directory if needed
WORKDIR /app
