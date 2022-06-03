# Kernel Instructions

- Create a folder corresponding to the version number in the `amlogic-kernel` directory, such as `5.15.25` , and put the 4 needed kernel files into this directory (Other kernel files are not required, and putting them in does not affect use). Multiple kernels create directories in turn and put corresponding kernel files. Kernel files can be downloaded from the [kernel](https://github.com/lasthinker/kernel) repository. If the kernel file is not downloaded and stored manually, the script will also be automatically downloaded from the kernel repository at compile time.

```yaml
~/amlogic-s9xxx-armbian
    └── build-armbian
        └── amlogic-kernel
            ├── 5.10.100
            │   ├── header-5.10.100-lasthinker.tar.gz
            │   ├── boot-5.10.100-lasthinker.tar.gz
            │   ├── dtb-amlogic-5.10.100-lasthinker.tar.gz
            │   └── modules-5.10.100-lasthinker.tar.gz
            │
            ├── 5.15.25
            │   ├── header-5.15.25-lasthinker.tar.gz
            │   ├── boot-5.15.25-lasthinker.tar.gz
            │   ├── dtb-amlogic-5.15.25-lasthinker.tar.gz
            │   └── modules-5.15.25-lasthinker.tar.gz
            │
            ├── more kernel...
```
