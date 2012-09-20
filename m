From: ajellisuk@yahoo.co.uk (Ellis Andrew)
Date: Thu, 20 Sep 2012 13:54:50 +0100 (BST)
Subject: Problems with frame buffer driver with MCS8144 
Message-ID: <1348145690.98766.YahooMailNeo@web133204.mail.ir2.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I have managed to build the kernel for my project with support for a 
frame buffer driver. When the kernel is booting I see several messages 
in the console indicating the driver is loading and I can briefly see the linux penguin is shown on the VDU when "mcs8142_vga_probe: platform register", then it disappears shortly after this message is shown, "mcs8142_vga_probe: EXIT, returning 0"
I cannot work out from which point the driver is loaded and where the 
parameters for a display of 1600x1050 are passed. Can someone please 
enlighten me on that. If I do an ls /dev/ I cannot see a reference to 
fb0, but if I compile and run the example app from here Enabling the Linux Framebuffer the application says that The frame buffer device was opened successfully. The application fails when it tries to read fixed information from the driver, so no image is displayed.

How do I enable the display when the kernel has finished booting? In the
 make menu I have enabled the Framebuffer Console support, and  Map the 
console to the primary display device.

Kind regards
Andrew 
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120920/abab6e1e/attachment-0001.html>
