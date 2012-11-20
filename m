From: bevenson@melinkcorp.com (Bryan Evenson)
Date: Tue, 20 Nov 2012 08:37:20 -0500
Subject: Help building 3.x kernel for AT91SAM9x5
Message-ID: <91586D499ADFD74FBCFB8425266A5DE40137631A48C0@pluto.melinkcorp.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All,

I have a AT91SAM9G25 board that I have been using with the 2.6.39 kernel and the Atmel supported patches for this kernel using the classic Open Embedded development tree.  I need to move to a 3.x kernel to incorporate the AT91 ADC driver and the bug fixes for the RS-485 interface (so I would probably need 3.5 or later).  However, all attempts I have made at building a 3.x kernel for the AT91SAM9G25 have failed to produce a bootable kernel image.  I have tried modifying the OE kernel recipe to utilize a 3.x kernel and I have tried using the Yocto Project tools to build a custom BSP, both of which have failed no matter how I tweak the setup.  Each attempt ends in the same results; U-Boot unpacks the kernel, jumps to the start of the kernel and then the system hangs.  I am looking for assistance in getting a 3.x kernel booting on this device.  I have tried getting help from the Atmel Linux forums and the Yocto Project forums and have not yet had success, so I decided to move closer to the source.

If anyone can offer assistance in getting a bootable 3.x kernel for the AT91SAM9G25 I would greatly appreciate it.  I would prefer pointers in how to modify a Bitbake kernel recipe for use with OE or the Yocto Project, but instructions on how to build this kernel with CodeSourcery would also be helpful.

Once I get my system up and running, if there SAM9x5 kernel features that need to be tested I would gladly help with testing.

Thanks,
Bryan Evenson
