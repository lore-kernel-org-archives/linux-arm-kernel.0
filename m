From: gigin_jose@yahoo.co.in (GIGIN JOSE)
Date: Thu, 14 Jul 2011 11:20:13 +0000 (UTC)
Subject: CMOS camera interface on ARM
Message-ID: <loom.20110714T130539-468@post.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, 

I am working on ARM9 based linux embedded system. I need to 
interface a CMOS camera on the SoC. The processor I use is 
samsung s3c2416, which does not have a camera interface. 
The linux version I use is 2.6.21

With the standard resolutions(640*480) and fps
 (~25 fps) configured on the camera, I am getting the 
clock rates as below:
Master clock: 24 MHz
Pixel Clock : 8MHz
HSYNC       : 20KHz
VSYNC       : 25Hz

The Bit Resolution I use is 8bpp. 

Using the regular interrupt lines (external interrupts),
 will I be able to read the 8 bit camera data coming 
with each pixel ? Can I do this with regular IRQ interrupt
 or should I configure my interrupts to be FIQ ? 
Is there any generic driver available for this 
kind of interface in linux. What is the interrupt
 latency if I configure the external interrupts in FIQ mode 
and IRQ mode ? 


Thank You
