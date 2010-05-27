From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 27 May 2010 23:01:12 +0200
Subject: Controlling Driver Load Order
In-Reply-To: <AANLkTilKUfcYsPqr5kXlONJQAFCaE8D8U9ltQybIzCPu@mail.gmail.com>
References: <AANLkTikzDvWakd7JW3DzTHinjS3dAlqzPx6K8V2qMDG7@mail.gmail.com>
	<AANLkTinkY8JYh44UOEPflBUDyQ2wat_AKShRjA3HPxrf@mail.gmail.com>
	<20100526235246.GA31068@pengutronix.de>
	<AANLkTikj8yGSK5Ovud_k8f6jWloojqDJmQ_H6pD_IFgM@mail.gmail.com>
	<20100527041358.GA14070@pengutronix.de>
	<AANLkTilKUfcYsPqr5kXlONJQAFCaE8D8U9ltQybIzCPu@mail.gmail.com>
Message-ID: <20100527210112.GA5636@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Anyway, I better understand the subsys_initcall now and applied that
> to the i2c-gpio and my i2c chip driver.  That worked perfectly for my

With chip-driver you mean the PMIC? Yes, that is probably needed there, too.
Which driver is it?

> issue.  I'd be happy to return a patch of this.  Would be this the
> sort of thing that would benefit from a config option?  Something

Nope, there is no bigger drawback to this and probably a number of useres
wouldn't know what to select here. Just patch the module_init() away.

Kind regards,

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100527/89732004/attachment.sig>
