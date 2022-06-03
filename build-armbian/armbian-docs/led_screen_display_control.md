# LED screen display control instructions

- The configuration file is placed in the [/usr/share/openvfd](https://github.com/lasthinker/amlogic-s9xxx-armbian/tree/main/build-armbian/common-files/rootfs/usr/share/openvfd) directory of the `Armbian/OpenWrt` system, and the command file for `Armbian` systems is located at [/usr/sbin/armbian-led](https://github.com/lasthinker/amlogic-s9xxx-armbian/blob/main/build-armbian/common-files/rootfs/usr/sbin/armbian-led), and the command file for `OpenWrt` systems is located at [/usr/sbin/openwrt-led](https://github.com/lasthinker/amlogic-s9xxx-openwrt/blob/main/amlogic-s9xxx/common-files/rootfs/usr/sbin/openwrt-led). If it is not in the current firmware, it can be uploaded manually, And give the file execute permission: `chmod +x /usr/share/openvfd/vfdservice /usr/sbin/*-led`

- Upgrade your system's kernel to version 5.4.187, 5.10.108, 5.15.31, 5.16.17 or later. `Armbian` systems are updated using the `armbian-update` command. For `OpenWrt` system, use `System menu` → `Amlogic Service` → `Online Download Update` to upgrade the function.

- At present, there are several boxes such as `x96max.conf`, `x96maxplus.conf`, `h96max-x3.conf`, `hk1-x3.conf`, `hk1box.conf`, `tx3.conf`, `x96air.conf` etc. that have passed the test. The configuration of other devices can be viewed: [arthur-liberman/vfd-configurations](https://github.com/arthur-liberman/vfd-configurations) and [LibreELEC/linux_openvfd](https://github.com/LibreELEC/linux_openvfd/tree/master/conf) to modify, It is necessary to adjust the corresponding content in the configuration files of these two websites, and use it after subtracting `1` from the value of the second field, such as:

```yaml
vfd_gpio_clk='0,69,0'
vfd_gpio_dat='0,70,0'
```
change into:

```yaml
vfd_gpio_clk='0,68,0'
vfd_gpio_dat='0,69,0'
```

- Take the configuration of [x96maxplus](https://github.com/lasthinker/amlogic-s9xxx-armbian/blob/main/build-armbian/common-files/rootfs/usr/share/openvfd/conf/x96maxplus.conf) as an example: if the displayed time and text order is not correct, you can adjust the numerical order of `vfd_chars='4,0,1,2,3'` to `vfd_chars='1,2,3,4,0'`, etc. for testing. If the time is displayed in reverse, you can adjust the `first value 0x02` in `vfd_display_type='0x02,0x00,0x01,0x00'` to `0x01`, etc. for testing. The displayed content can adjust the value in `functions='usb apps setup sd hdmi cvbs'` according to the specific situation supported by your own device

- Name the configuration file `diy.conf` and upload it to the `/usr/share/openvfd/conf` directory, enter the command `armbian-led 99` to test.

- You can disable the LED display and clear system processes with the command `armbian-led 0`, before each test a new configuration, please execute this disable command first, and then execute `armbian-led 99` to make changes After the configuration test.

- After the screen is displayed normally, you can add it to the self-starting task at boot, Please modify the `15` in the following command according to the serial number corresponding to the box in the `armbian-led` option:

```yaml
# Execute the following command in the terminal to add the Armbian system
sed -i '/armbian-led/d' /etc/rc.local
sed -i '/exit 0/i\armbian-led 15' /etc/rc.local

# Execute the following command in the terminal to add the OpenWrt system
sed -i '/openwrt-led/d' /etc/rc.local
sed -i '/exit 0/i\openwrt-led 15' /etc/rc.local
```

- You are welcome to share the conf file(xxx.conf) of your own devices after testing, so that more people can benefit.

|     Box    |   ID   |  Armbian Command  |   OpenWrt Command   |  Function   |
| ---------- |  ----- | ----------------- | ------------------- | ----------- |
| -          |  0     |  armbian-led 0    |   openwrt-led 0     | Disable LED |
| x96max     |  11    |  armbian-led 11   |   openwrt-led 11    | Enable LED  |
| x96maxplus |  12    |  armbian-led 12   |   openwrt-led 12    | Enable LED  |
| x96air     |  13    |  armbian-led 13   |   openwrt-led 13    | Enable LED  |
| h96max-x3  |  14    |  armbian-led 14   |   openwrt-led 14    | Enable LED  |
| hk1-x3     |  15    |  armbian-led 15   |   openwrt-led 15    | Enable LED  |
| hk1box     |  16    |  armbian-led 16   |   openwrt-led 16    | Enable LED  |
| tx3        |  17    |  armbian-led 17   |   openwrt-led 17    | Enable LED  |
| tx3-mini   |  18    |  armbian-led 18   |   openwrt-led 18    | Enable LED  |
| t95        |  19    |  armbian-led 19   |   openwrt-led 19    | Enable LED  |
| tx9-pro    |  20    |  armbian-led 20   |   openwrt-led 20    | Enable LED  |
| diy        |  99    |  armbian-led 99   |   openwrt-led 99    | Enable LED  |

