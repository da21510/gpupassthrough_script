# gpupassthrough script

setup-modules will auto setup 
1.grub(Intel CPU iommu=on) 
2.required modules 
3.blacklist GPU original drivers 

setup-vfio will detect all GPU and make them use vfio driver
