#!/bin/bash
dnf install -y gcc make kernel-devel || echo "BuildFailure"
curl -L -o nvidia.run https://us.download.nvidia.com/tesla/550.90.12/NVIDIA-Linux-x86_64-550.90.12.run || echo "BuildFailure"
chmod +x ./nvidia.run || echo "BuildFailure"
# DKMS - not suitable for prod
./nvidia.run -s --kernel-source-path=/usr/src/kernels/5.14.0-427.28.1.el9_4.cloud.1.0.x86_64/ || echo "BuildFailure"
dnf install -y rdma-core || echo "BuildFailure"
nvidia-smi || echo "BuildFailure"
echo "BuildSuccess"
