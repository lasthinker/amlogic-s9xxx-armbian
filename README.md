# Armbian for Amlogic S9XXX

The [Armbian](https://www.armbian.com/) system is a lightweight Linux system based on Debian/Ubuntu built specifically for ARM chips. The Armbian system is lean, clean, and 100% compatible and inherits the functions and rich software ecosystem of the Debian/Ubuntu system. It can run safely and stably in TF/SD/USB and the eMMC of the device.

The latest version of the Armbian firmware can be downloaded in [Releases](https://github.com/lasthinker/amlogic-s9xxx-armbian/releases). Welcome to `Fork` and personalize it. If it is useful to you, you can click on the `Star` in the upper right corner of the warehouse to show your support.

💡Tip: The current ***`s905w`*** series of TV Boxes only support the use of the `5.15.y` kernel, Other types of TV Boxes can use optional kernel versions. Currently ***`s905`*** TV Boxes can only be used in `TF/SD/USB`, other types of TV Boxes also support writing to `EMMC`. Please refer to the [instructions](build-armbian/armbian-docs/amlogic_model_database.md) for dtb and u-boot of each device.

## Install to EMMC and update instructions

Choose the corresponding firmware according to your box. Then write the IMG file to the USB hard disk through software such as [Rufus](https://rufus.ie/) or [balenaEtcher](https://www.balena.io/etcher/). Insert the USB hard disk into the box. Common for all `Amlogic S9XXX TV Boxes`.

- ### Install Armbian to EMMC

Login in to armbian (default user: root, default password: 1234) → input command:

```yaml
armbian-install
```

The mainline u-boot is installed by default, In order to support the use of 5.10 and above kernels. If you choose not to install, specify it in the `1` input parameter, e.g. `armbian-install no`

- ### Update Armbian Kernel

Login in to armbian → input command:

```yaml
# Run as root user (sudo -i)
# If no other parameters are specified, the following update command will update to the latest version of the current kernel of the same series.
armbian-update
```

If there is a set of kernel files in the current directory, it will be updated with the kernel in the current directory (The 4 kernel files required for the update are `header-xxx.tar.gz`, `boot-xxx.tar.gz`, `dtb-amlogic-xxx.tar.gz`, `modules-xxx.tar.gz`. Other kernel files are not required. If they exist at the same time, it will not affect the update. The system can accurately identify the required kernel files). If there is no kernel file in the current directory, it will query and download the latest kernel of the same series from the server for update. You can also query the [optional kernel](https://github.com/lasthinker/kernel/tree/main/pub/stable) version and update the specified version: `armbian-update 5.10.100`. The optional kernel supported by the device can be freely updated, such as from 5.10.100 kernel to 5.15.25 kernel. When the kernel is updated, By default, download from [stable](https://github.com/lasthinker/kernel/tree/main/pub/stable) kernel version branch, if you download other [version branch](https://github.com/lasthinker/kernel/tree/main/pub), please specify according to the branch folder name in the `2` parameter, such as `armbian-update 5.4.195 dev` . The mainline u-boot will be installed automatically by default, which has better support for kernels using versions above 5.10. If you choose not to install, please specify it in the `3` input parameter, such as `armbian-update 5.10.100 stable no `

- ### Install Docker Service

Login in to armbian → input command:

```yaml
armbian-docker
```

After installing docker, you can choose whether to install the `portainer` visual management panel. Users who intend to use the `LAN IP` for management can choose (`h`) to install the `http://ip:9000` version; Users who intend to use the `domain name` for remote management can choose (`s`) to install the `https://domain:9000` domain name certificate version (Please name the domain name `SSL` certificate as `portainer.crt` and `portainer.key` and upload it to the `/etc/ssl/` directory); Users who `do not need` to install can choose (`n`) to end the installation.

- ### Modify Armbian Config

Login in to armbian → input command:

```yaml
armbian-config
```

- ### Create swap for Armbian

If you feel that the memory of the current box is not enough when you are using applications with a large memory footprint such as `docker`, you can create a `swap` virtual memory partition, Change the disk space a certain capacity is virtualized into memory for use. The unit of the input parameter of the following command is `GB`, and the default is `1`.

Login in to armbian → input command:

```yaml
armbian-swap 1
```

- ### Controlling the LED display

Login in to armbian → input command:

```yaml
armbian-led
```

Debug according to [LED screen display control instructions](build-armbian/armbian-docs/led_screen_display_control.md).

- ### Use Armbian in TF/SD/USB

To activate the remaining space of TF/SD/USB, please login in to armbian → input command:

```yaml
armbian-tf
```

According to the prompt, enter `e` to expand the remaining space to the current system partition and file system, and enter `c` to create a new third partition.

<details>
  <summary>Or manually allocate the remaining space</summary>

#### View [Operation screenshot](https://user-images.githubusercontent.com/68696949/137860992-fbd4e2fa-e90c-4bbb-8985-7f5db9f49927.jpg)

```yaml
# 1. Confirm the name of the TF/SD/USB according to the size of the space. The TF/SD is [ `mmcblk` ], USB is [ `sd` ]
Command: Enter [ fdisk -l | grep "sd" ]

# 2. Get the starting value of the remaining space, Copy and save, used below  (E.g: 5382144)
Command: Enter [ fdisk -l | grep "sd" | sed -n '$p' | awk '{print $3}' | xargs -i expr {} + 1 ]

# 3. Start allocating unused space (E.g: sda, mmcblk0 or mmcblk1)
Command: Enter [ fdisk /dev/sda ] Start allocating the remaining space
Command: Select [ n ] to create a partition
Command: Select [ p ] to specify the partition type as primary partition
Command: Set the partition number to [ 3 ]
Command: The start value of the partition, enter the value obtained in the second step, E.g: [ 5382144 ]
Command: End value, press [ Enter ] to use the default value
Command: If there is a hint: Do you want to remove the signature? [Y]es/[N]o: Enter [ Y ]
Command: Enter [ t ] to specify the partition type
Command: Enter Partition number [ 3 ]
Command: Enter Hex code (type L to list all codes): [ 83 ]
Command: Enter [ w ] to save
Command: Enter [ reboot ] to restart

# 4. After restarting, format the new partition
Command: Enter [ mkfs.ext4 -F -L SHARED /dev/sda3 ] to format the new partition

# 5. Set the mount directory for the new partition
Command: Enter [ mkdir -p /mnt/share ] to Create mount directory
Command: Enter [ mount -t ext4 /dev/sda3 /mnt/share ] to Mount the newly created partition to the directory

# 6. Add automatic mount at boot
Command: Enter [ vi /etc/fstab ]
# Press [ i ] to enter the input mode, copy the following values to the end of the file
/dev/sda3 /mnt/share ext4 defaults 0 0
# Press [ esc ] to exit, Input [ :wq! ] and [ Enter ] to Save, Finish.
```
</details>

- ### Backup/restore the original EMMC system

Supports backup/restore of the box's `EMMC` partition in `TF/SD/USB`. It is recommended that you back up the Android TV system that comes with the current box before installing the Armbian system in a brand new box, so that you can use it in the future when restoring the TV system.

Please login in to armbian → input command:

```yaml
armbian-ddbr
```

According to the prompt, enter `b` to perform system backup, and enter `r` to perform system recovery.

## Armbian firmware default information

| Name | Value |
| ---- | ---- |
| Default IP | Get IP from the router |
| Default username | root |
| Default password | 1234 |

## Acknowledgments

- [armbian](https://github.com/armbian/build)
- [unifreq](https://github.com/unifreq)
- [ophub](https://github.com/ophub)

## License

[LICENSE](https://github.com/lasthinker/amlogic-s9xxx-armbian/blob/main/LICENSE) © lasthinker

