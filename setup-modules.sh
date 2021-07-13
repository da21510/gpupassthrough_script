#!/bin/bash

sed -i '/GRUB_CMDLINE_LINUX_DEFAULT/s/quiet/quiet intel_iommu=on pcie_aspm=off video=efifb:off,vesafb:off/g' /etc/default/grub
update-grub

echo vfio >> /etc/modules
echo vfio_iommu_type1 >> /etc/modules
echo vfio_pci >> /etc/modules
echo vfio_virqfd >> /etc/modules

echo "blacklist radeon" >> /etc/modprobe.d/blacklist.conf
echo "blacklist amdgpu" >> /etc/modprobe.d/blacklist.conf
echo "blacklist nouveau" >> /etc/modprobe.d/blacklist.conf
echo "blacklist nvidia" >> /etc/modprobe.d/blacklist.conf

echo "options kvm ignore_msrs=1" > /etc/modprobe.d/kvm.conf
