---
layout: post
title: "Installing CUDA in WSL"
date: 2025-12-30
tags: [ "cuda", "wsl", "windows" ]
---

Step one takes place in a powershell terminal.

```powershell
winget install Docker Desktop


dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

wsl.exe --install
wsl.exe --update

# wsl.exe --list --online
wsl.exe --install Ubuntu
```


This step takes place in the WSL terminal.

```bash
sudo apt update -y
sudo apt upgrade -y

sudo apt-key del 7fa2af80

wget https://developer.download.nvidia.com/compute/cuda/repos/wsl-ubuntu/x86_64/cuda-wsl-ubuntu.pin

sudo mv cuda-wsl-ubuntu.pin /etc/apt/preferences.d/cuda-repository-pin-600

wget https://developer.download.nvidia.com/compute/cuda/12.8.1/local_installers/cuda-repo-wsl-ubuntu-12-8-local_12.8.1-1_amd64.deb

sudo dpkg -i cuda-repo-wsl-ubuntu-12-8-local_12.8.1-1_amd64.deb

sudo cp /var/cuda-repo-wsl-ubuntu-12-8-local/cuda-*-keyring.gpg /usr/share/keyrings/

sudo apt update -y

sudo sudo apt-get -y install cuda-toolkit-12-8
```


---

## Resources

- [Enable NVIDIA CUDA on WSL](https://learn.microsoft.com/en-us/windows/ai/directml/gpu-cuda-in-wsl)
- [CUDA on WSL User Guide](https://docs.nvidia.com/cuda/wsl-user-guide/index.html)
- [CUDA Installation Guide for Linux](https://docs.nvidia.com/cuda/cuda-installation-guide-linux/#meta-packages)
- [How to install CUDA on WSL2 ](https://dev.to/gabriellavoura/how-to-install-cuda-on-wsl2-45g6)
