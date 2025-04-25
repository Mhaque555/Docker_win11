#!/bin/bash

# Notify the user that the setup has started
echo "▶ Starting the Windows Docker container setup..."

# Define the configuration values inside the script
VERSION="win11"          # Windows version to run
RAM_SIZE="12G"            # RAM allocation for the container
CPU_CORES="64"            # Number of CPU cores to allocate
DISK_SIZE="256G"         # Disk size for the container

# Generate the compose.yaml file with the configuration values
cat <<EOF > compose.yaml
services:
  windows:
    image: dockurr/windows
    container_name: windows
    devices:
      - /dev/kvm               # KVM device for virtualization support
    cap_add:
      - NET_ADMIN              # Grant additional networking capabilities
    ports:
      - 8006:8006              # Expose port 8006 for web access (if available)
      - 3389:3389/tcp          # RDP over TCP
      - 3389:3389/udp          # RDP over UDP
    stop_grace_period: 2m     # Grace period before stopping the container
    restart: on-failure       # Restart the container if it fails
    environment:
      VERSION: "$VERSION"      # Pass Windows version
      RAM_SIZE: "$RAM_SIZE"    # Pass RAM size
      CPU_CORES: "$CPU_CORES"  # Pass CPU cores
      DISK_SIZE: "$DISK_SIZE"  # Pass disk size
    volumes:
      - /tmp:/storage           # Mount temporary storage to the container
EOF

# Start the container using Docker Compose
docker compose up -d

# Notify the user that the setup is complete and provide access info
echo "🌐 RDP: localhost:3389"           # Remote Desktop Protocol access
echo "🌐 Web UI (if available): http://localhost:8006"  # Web interface access (if supported by the image)
