#!/bin/sh
set -x
export DEBIAN_FRONTEND=noninteractive
apt update -y || echo "BuildFailure"
apt upgrade -y || echo "BuildFailure"
# DKMS - not suitable for prod
apt -y install nvidia-driver-550-server rdma-core || echo "BuildFailure"
# This is only for mlx5_ib - once that's in the main package stop including it
apt install linux-modules-extra-$(uname -r) || echo "BuildFailure"
tee /usr/bin/add-nvidia-repositories << EOF
#!/bin/bash
set -e
curl https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-keyring_1.1-1_all.deb -o /tmp/cuda-keyring_1.1-1_all.deb
dpkg -i /tmp/cuda-keyring_1.1-1_all.deb
EOF
chmod +x /usr/bin/add-nvidia-repositories || echo "BuildFailure"
echo "BuildSuccess"