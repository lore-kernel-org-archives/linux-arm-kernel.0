From: gigin_jose@yahoo.co.in (GIGIN JOSE)
Date: Fri, 19 Aug 2011 05:25:22 +0000 (UTC)
Subject: enable two usb host on s3c2416 processor
Message-ID: <loom.20110819T071755-841@post.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, 

I am using ARM9 based s3c2416 processor. The SoC has one USB host 
controller and one USB host/device controller. What are the 
register settings that should be done to enable both USB 
interfaces as USB host controller. ? There is a register PHYCTRL
 with address 0x4C00_0080. Its bit[0] says something on USB host
 mode and USB device mode. Is it this register which I should 
work on or any more register configurations are required ? 

Thank You
GIGIN
