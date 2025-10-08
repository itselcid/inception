FROM debian:bullseye

RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

RUN curl -L https://github.com/google/cadvisor/releases/download/v0.47.0/cadvisor-v0.47.0-linux-amd64 \
    -o /usr/bin/cadvisor && chmod +x /usr/bin/cadvisor

CMD ["/usr/bin/cadvisor"]
