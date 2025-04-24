#!/bin/bash

echo "▶ উইন্ডোজ ডকার কন্টেইনার সেটআপ শুরু হচ্ছে..."

# কনফিগারেশন ভ্যালুগুলো স্ক্রিপ্টেই দেয়া
VERSION="win11"
RAM_SIZE="8G"
CPU_CORES="4"
DISK_SIZE="256G"

# compose.yaml তৈরি
cat <<EOF > compose.yaml
services:
  windows:
    image: dockurr/windows
    container_name: windows
    devices:
      - /dev/kvm
    cap_add:
      - NET_ADMIN
    ports:
      - 8006:8006
      - 3389:3389/tcp
      - 3389:3389/udp
    stop_grace_period: 2m
    restart: on-failure
    environment:
      VERSION: "$VERSION"
      RAM_SIZE: "$RAM_SIZE"
      CPU_CORES: "$CPU_CORES"
      DISK_SIZE: "$DISK_SIZE"
    volumes:
      - /tmp:/storage
EOF

# কন্টেইনার চালু
docker compose up -d

echo "✅ উইন্ডোজ কন্টেইনার এখন চলছে!"
echo "🌐 RDP: localhost:3389"
echo "🌐 Web UI (যদি থাকে): http://localhost:8006"
