From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 27 May 2010 23:42:09 +0200
Subject: Controlling Driver Load Order
In-Reply-To: <4BFEDF6D.3090100@bluewatersys.com>
References: <AANLkTikzDvWakd7JW3DzTHinjS3dAlqzPx6K8V2qMDG7@mail.gmail.com>
	<AANLkTinkY8JYh44UOEPflBUDyQ2wat_AKShRjA3HPxrf@mail.gmail.com>
	<20100526235246.GA31068@pengutronix.de>
	<AANLkTikj8yGSK5Ovud_k8f6jWloojqDJmQ_H6pD_IFgM@mail.gmail.com>
	<20100527041358.GA14070@pengutronix.de>
	<AANLkTilKUfcYsPqr5kXlONJQAFCaE8D8U9ltQybIzCPu@mail.gmail.com>
	<4BFEDF6D.3090100@bluewatersys.com>
Message-ID: <20100527214209.GC5636@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Looks like this has already been done:
> http://www.mail-archive.com/linux-i2c at vger.kernel.org/msg03056.html

Always ask which kernel is used, sigh...

> 
> There was a discussion a while back to make all of the embedded i2c
> busses be subsys_initcall since i2c is often a system bus on embedded

Oh, where was that? Can't recall (but couldn't recall that I acked the i2c-gpio
patch above as well ;))

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 197 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100527/79d43255/attachment.sig>
