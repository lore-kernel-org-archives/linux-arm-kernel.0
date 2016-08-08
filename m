From: anshexp@gmail.com (Anshuman Gupta)
Date: Mon, 8 Aug 2016 23:26:13 +0530
Subject: 1 of 705 Linux 4.7.0 on freescale imx6 quad udoo board.
Message-ID: <CADo9au1MD=H_1Jn+d0j8+O8gRChAtmp1uZ=fgKEpS+z+w94RLA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I am trying to boot the udoo (freescale imx6 quad) with vanilla linux
kernel 4.7.0 with  ubuntu  file system.

I am trying a root over nfs , kernel boots successfully and  `root
file system mounted

but the shell is not launching it seems it has locked up somewhere ,
console just get hang.

whether it is a issue with init/file system or kernel.

Any help or point to debug this further will  be highly appreciated.

Sorry if this is wrong mailing  list to post this query , if it is
please tell me the right mailing list.

Below here it is the log snippet

-------------------------------------------------------------------------------------------------------------
[    4.606736] Sending DHCP requests .., OK
[    7.216728] IP-Config: Got DHCP answer from 192.168.1.1, my address is 192.16
8.1.38
[    7.224527] IP-Config: Complete:
[    7.227791]      device=eth0, hwaddr=00:01:02:b4:36:56, ipaddr=192.168.1.38,
mask=255.255.255.0, gw=192.168.1.1
[    7.237896]      host=192.168.1.38, domain=, nis-domain=(none)
[    7.243735]      bootserver=0.0.0.0, rootserver=192.168.1.36, rootpath=     n
ameserver0=192.168.1.1
[    7.252847] vddpu: disabling
[    7.255739] usb_h1_vbus: disabling
[    7.259166] lcd_panel: disabling
[    7.262608] ALSA device list:
[    7.265583]   No soundcards found.
[    7.308990] VFS: Mounted root (nfs filesystem) readonly on device 0:12.
[    7.316079] devtmpfs: mounted
[    7.319969] Freeing unused kernel memory: 1024K (80a00000 - 80b00000)
[    7.362780] random: fast init done
[    9.010585] init: mounted-proc main process (129) terminated with status 1
---------------------------------------------------------------------------------------------------------------


Thanks in Advanced

Anshuman
