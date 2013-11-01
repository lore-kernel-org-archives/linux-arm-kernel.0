From: al4321@gmail.com (Alexey Eromenko)
Date: Fri, 1 Nov 2013 17:48:54 +0200
Subject: Donation of Allwinner-based CubieTruck to anyone interested in
 developing & upstreaming
Message-ID: <CAOJ6w=FGjOrW5Ukzet4gsa4grkyZQei+OJfU4N_HqdKmaFjntw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

My name is Alexey, and I'm interested in having ARM CubieTruck
hardware well supported by Debian for desktop (KDE) use.

CubieTruck is an ARM mini-PC aka "Liliputer", based on AllWinner A20
SoC + 2 GB RAM + 8 GB flash + VGA (!) port + SATA + Ethernet + WiFi,
making it good enough for a real Debian desktop.

CubieTruck
http://cubietruck.com/collections/frontpage/products/cubietruck-cubieboard3-cortex-a7-dual-core-2gb-ram-8gb-flash-with-wifi-bt

My goal: It should have a working 2D, HD Video and 3D graphics as well
as audio and networking.

Some open-source drivers exist:
*2D - xf86-video-fbturbo - link: https://github.com/ssvb/xf86-video-fbturbo
*Hardware Video Decoder - "CedarX" link:
http://linux-sunxi.org/Reverse_Engineering/Cedar_Status
*3D - open-source Lima or closed-source Mali drivers.

WiFi + Bluetooth - status unknown. (WiFi firmware is probably closed source)

The problem is that the Allwinner Linux kernel is a fork of the real Linux 3.4.x
If you can - please help mainline those patches & drivers and
integrate them upstream.
Additional involvement in docs + graphics drivers is welcome.

Worth reading: Getting Allwinner SoC support upstream:
http://www.phoronix.com/scan.php?page=news_item&px=MTM4NDc

and here:
http://lkml.indiana.edu/hypermail/linux/kernel/1306.0/02744.html

I will donate few ARM CubieTruck samples to interested people. You'll
need a proof of past patches to any open-source project or community
involvement.
--
-Alexey Eromenko "Technologov", Debian user. Open-source community
member. Israel.
