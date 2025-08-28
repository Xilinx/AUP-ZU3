---
layout: default
---

# AUP-ZU3 support

## PYNQ support

Questions about using PYNQ on the AUP-ZU3 can be posted to the PYNQ support forum:

* [https://discuss.pynq.io](https://discuss.pynq.io)

You can also post your own projects in the [Community Corner](https://discuss.pynq.io/c/community-projects-chat/14) on the PYNQ support forum. 



## AMD support

Questions related to AMD Vivado or Vitis tools and building designs for your board, including HLS designs, can be posted on the AMD technical support forums:

* [https://adaptivesupport.amd.com/](https://adaptivesupport.amd.com/)



## Hardware problems

Follow the troubleshooting guide below, and post questions on the [PYNQ support forum](https://discuss.pynq.io/). If you have a problem with you board and you suspect the board is damaged, please contact the manufacturer [Real Digital](https://www.realdigital.org).



## Troubleshooting

Check the [PYNQ Documentation](http://pynq.readthedocs.io/) for FAQs related to PYNQ. 



## AUP-ZU3 FAQ

  
* ** The board does not boot properly**

  * Connect a serial terminal and check the boot console

* **I do not see any LEDs after turning on the board**

  This indicates there is not a suitable power supply going to the board, or the board is dead.

  * Check the power cables, and the power source you are using. If you are using a USB-C port on your laptop or PC, it must be able to supply 9V @ 3A. 

  * Check the power switch is in the correct position

* **I I do not see the PS LEDs after I turn on the board**

  This indicates the PS is not booting the PYNQ image

  * Check the SD card is inserted, and has a valid PYNQ image
  
  * Try reflash the same SD card with the PYNQ image, or ideally a different SD card

* **I do not see the DONE LED or the flashing white and RGB LEDs**

  This indicates the PS has not booted properly. 

  * Check the SD card has a valid PYNQ image

  * Connect a serial terminal and check the boot console

    If the boot process stalls, or continuously restarts, try to capture the console information and post it to the [PYNQ support forum](https://discuss.pynq.io). 

* **I have no Ethernet connection/I do not see the new connection on my computer**

  * On your host computer, check if a new Ethernet device is available in your network connections. You may need to check hardware manager in Windows, and the equivalent in other operating systems, to see if the Ethernet device was recognized, and if the driver was automatically loaded.  

  * Check the USB cable is connected to your host PC and board.

* **I cannot connect to Jupyter**

  * I get a "404" or the webpage for the board doesn't load

  * Connect a serial terminal, and check the boot log. Check if Jupyter Notebook server has started, and that it is still running. 

    You can do this by checking if the following command returns something:

    `ps -ef | grep Jupyter` 

    e.g. 

    ```
    root    1434  1405  0 09:16 pts/0   00:00:00
    ```

  * Check the IP address for the board, and make sure you are connecting to a valid address, and the interface is up.  

    `ip a` 

    e.g. USB gadget on **usb0** with IP address: **192.168.3.1**

    ```
	xilinx@pynq:~$ ip a
	1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
		link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
		inet 127.0.0.1/8 scope host lo
		   valid_lft forever preferred_lft forever
		inet6 ::1/128 scope host
		   valid_lft forever preferred_lft forever
	2: dummy0: <BROADCAST,NOARP> mtu 1500 qdisc noop state DOWN group default qlen 1000
		link/ether 8a:2e:7f:fe:2d:54 brd ff:ff:ff:ff:ff:ff
	3: sit0@NONE: <NOARP> mtu 1480 qdisc noop state DOWN group default qlen 1000
		link/sit 0.0.0.0 brd 0.0.0.0
	4: usb0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc pfifo_fast state DOWN group default qlen 1000
		link/ether 32:5f:8f:85:5b:f1 brd ff:ff:ff:ff:ff:ff
		inet 192.168.3.1/24 brd 192.168.3.255 scope global usb0
		   valid_lft forever preferred_lft forever
	```


    ---------------------------------------
<p class="copyright">Copyright&copy; 2025 Advanced Micro Devices</p>

  

