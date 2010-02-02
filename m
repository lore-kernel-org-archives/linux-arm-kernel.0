From: Colin.Tuckley@arm.com (Colin Tuckley)
Date: Tue, 2 Feb 2010 09:07:47 +0000
Subject: Uncompressing broken with commit e7db7b4270
In-Reply-To: <20100202090121.GC22848@pengutronix.de>
References: <1264698229.7064.93.camel@pc1117.cambridge.arm.com>
	<000001caa0fd$cef2f740$9fca010a@Emea.Arm.com>
	<20100202090121.GC22848@pengutronix.de>
Message-ID: <F01D8B85CFF58440B2A13965FBA90CA4177969@GEORGE.Emea.Arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Uwe Kleine-K?nig [mailto:u.kleine-koenig at pengutronix.de]

> What do you mean saying "kernel image"?  zImage, Image, vmlinux,
> arch/arm/boot/compressed/vmlinux?

It's actually a uImage (compressed image with u-boot 64 byte header).

> So where do you place your zImage, what is zreladdr, how big is your
> RAM?

It gets loaded by u-boot TFTP into RAM at the physical address of memory at 0x70000000 and we have either 512MB or 1GB of RAM depending on which system it is.

zreladdr is 0x70008000

regards,

Colin


--
Colin Tuckley - ARM Ltd.
110 Fulbourn Rd
Cambridge, CB1 9NJ
Tel: +44 1223 400536

-- IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium.  Thank you.
