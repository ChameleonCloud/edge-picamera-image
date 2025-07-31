FROM debian:bookworm-20250630-slim AS base

RUN apt-get update && apt-get install -y --no-install-recommends gnupg
RUN echo "deb http://archive.raspberrypi.org/debian/ bookworm main" > /etc/apt/sources.list.d/raspi.list \
  && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 82B129927FA3303E

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    python3-libcamera \
    python3-picamera2 \
    libcamera-apps-lite

WORKDIR /app

CMD ["sleep", "infinity"]
