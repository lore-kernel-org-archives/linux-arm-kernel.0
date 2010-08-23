From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Mon, 23 Aug 2010 18:44:38 -0500
Subject: i.MX353: mxc-ehci.0
Message-ID: <0D753D10438DA54287A00B0270842697643E840AE6@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello all,

What "magic" setup do I need to enable mxc-ehci.0 as a host controller?

I pulled git://git.pengutronix.de/git/imx/linux-2.6.git and have the
imx-for-2.6.37 branch compiled and booting, but I get this:

ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
mxc-ehci mxc-ehci.1: initializing i.MX USB Controller
mxc-ehci mxc-ehci.1: Freescale On-Chip EHCI Host Controller
mxc-ehci mxc-ehci.1: new USB bus registered, assigned bus number 1
mxc-ehci mxc-ehci.1: irq 35, io mem 0x53ff4400
mxc-ehci mxc-ehci.1: USB 2.0 started, EHCI 1.00
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected

It appears mxc-ehci.1 is working but I don't have that port on my board.

This is using the mach-mx35_3ds.c board configuration.

Thanks,
Hartley
