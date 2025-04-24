# 🪟 Windows 11 Docker Container (KVM-based)

This project allows you to easily run a lightweight Windows 11 container using Docker with KVM support on a Linux system. No `.env` file is required — all configuration is built into the setup script.

---

## 🧰 Requirements

- Docker and Docker Compose installed
- A Linux system with KVM virtualization support
  - To check if KVM is supported, run:
    ```bash
    egrep -c '(vmx|svm)' /proc/cpuinfo
    ```
    Output should be 1 or more.

---

## 🚀 How to Use

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/windows-docker.git
   cd windows-docker
