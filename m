From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Wed, 23 Mar 2011 22:35:49 +0100
Subject: [PATCH RESEND 0/4] USB: gadget: Add Samsung S3C24xx USB HS controller
	driver
Message-ID: <201103232235.49318.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2010-10-13 Sangbeom Kim sent 4 patches to add support the USB High-Speed
device controller module on Samsung's S3C2416, S3C2443 and S3C2450. [1]

bdooks worte on 2010-10-22:
> patch 3/4 needs a bit of work, otherwise looks ok.
> I'll look at applying the s3c24xx items in the next day or so.

On 2010-10-23 Kukjin Kim send a revised version of patch 3.
It seems the patches were forgotten after this.

We resurrected them while working on a s3c2416 based device. Patch 3 needed an 
update to work with current kernels. The other 3 patches were not modified.

Tests, comments, etc very welcome.

Thanks
Heiko


[1] http://comments.gmane.org/gmane.linux.kernel.samsung-soc/3315
[2] http://comments.gmane.org/gmane.linux.kernel.samsung-soc/3469

Sangbeom Kim wrote on 2010-10-13:
> The Samsung's S3C2416, S3C2443 and S3C2450 includes a USB High-Speed
> device controller module. This driver enables support for USB high-speed
> gadget functionality for the Samsung S3C24xx SoC's that include this
> controller.

The patch series contains:
[PATCH 1/4] ARM: S3C2416: Add USB Phy register definitions
[PATCH 2/4] ARM: S3C24XX: Add plaform device definition for USB High-Speed 
gadget controller.
[PATCH v2 3/4] USB: Gadget: Add Samsung S3C24XX USB High-Speed controller 
driver
[PATCH 4/4] ARM: S3C2416: Add support for USB 2.0 High-Speed gadget controller
