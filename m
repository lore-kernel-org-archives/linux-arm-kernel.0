From: jean-nicolas.graux@stericsson.com (Jean-Nicolas GRAUX)
Date: Tue, 12 Feb 2013 10:44:49 +0100
Subject: Getting your opinion about the best place to put one specific device
 driver...
Message-ID: <511A0F11.1050608@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello, Arnd, Olof. First, let me introduce myself quickly.
I am working in Stericsson and i am a colleague of Linus Walleij.
We are currently doing some cleaning in our mach-ux500 ARM machine.

Among other things, the U8500 SoC and its derivatives embed one small IP 
called the "hardware observer".
This is used for hardware debug purpose and it provides the ability to 
output some
modem, power, clocking, ..., hardware signals on 18 external wires.

We did one small platform device driver to handle this piece of hardware.
In the patch attached to this file, we kept the code in the mach-ux500 
machine folder.
But we are wondering where is the best place to put that stuff.
So, the question is: where should we put this code in the kernel tree ?

Thanks in advance for your advises.
Regards. Jean-Nicolas.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-ARM-ux500-introduce-hardware-observer-platform-drive.patch
Type: text/x-diff
Size: 27999 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130212/4c348ce9/attachment-0002.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0002-ARM-ux500-remove-hardware-observer-machine-code.patch
Type: text/x-diff
Size: 25978 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130212/4c348ce9/attachment-0003.bin>
