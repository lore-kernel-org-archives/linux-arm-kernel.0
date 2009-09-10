From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 10 Sep 2009 13:04:19 +0200
Subject: [PATCH 2/4] i2c/chips: Remove deprecated pcf8575-driver
In-Reply-To: <e2e108260909100352l2a30438fj9f0297c1974c0192@mail.gmail.com>
References: <1252531371-14866-1-git-send-email-w.sang@pengutronix.de>
	<1252531371-14866-3-git-send-email-w.sang@pengutronix.de>
	<e2e108260909100352l2a30438fj9f0297c1974c0192@mail.gmail.com>
Message-ID: <20090910110419.GA3266@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> This patch removes the documentation file
> Documentation/i2c/chips/pcf8575 while there is no documentation under
> Documentation/ for the drivers/gpio/pcf857x.c driver. Shouldn't proper
> documentation for the pcf857x driver be added to the kernel tree
> before the pcf8575 driver is removed ?

I considered moving the documentation, but realized:

1st part is URLs for datasheets. Well, URLs easily grow outdated and those
datasheets are easily to find using your favourite search engine.

2nd part is a short description of the chips which is IMHO sufficently covered
in drivers/gpio/Kconfig.

3rd part (Detection) and 4th part (sysfs-interface) are obsolete for the new
drivers. The gpiolib interface again is covered in Documentation/gpio.txt

So I concluded to simply drop the documentation.

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 197 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20090910/13b82fd3/attachment.sig>
