From: w.sang@pengutronix.de (Wolfram Sang)
Date: Fri, 28 May 2010 00:09:51 +0200
Subject: Controlling Driver Load Order
In-Reply-To: <4BFEEA08.70401@bluewatersys.com>
References: <AANLkTikzDvWakd7JW3DzTHinjS3dAlqzPx6K8V2qMDG7@mail.gmail.com>
	<AANLkTinkY8JYh44UOEPflBUDyQ2wat_AKShRjA3HPxrf@mail.gmail.com>
	<20100526235246.GA31068@pengutronix.de>
	<AANLkTikj8yGSK5Ovud_k8f6jWloojqDJmQ_H6pD_IFgM@mail.gmail.com>
	<20100527041358.GA14070@pengutronix.de>
	<AANLkTilKUfcYsPqr5kXlONJQAFCaE8D8U9ltQybIzCPu@mail.gmail.com>
	<4BFEDF6D.3090100@bluewatersys.com>
	<20100527214209.GC5636@pengutronix.de>
	<4BFEEA08.70401@bluewatersys.com>
Message-ID: <20100527220951.GD5636@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > Always ask which kernel is used, sigh...
> 
> Sorry? I didn't see a kernel version mentioned. I went looking because I
> had though that i2c-gpio was already subsys_initcall.

Sorry, I missed emphasizing that my comment was meant as a "note-to-myself".
You were perfectly right, of course, I should have done the same.

> >> There was a discussion a while back to make all of the embedded i2c
> >> busses be subsys_initcall since i2c is often a system bus on embedded
> > 
> > Oh, where was that? Can't recall (but couldn't recall that I acked the i2c-gpio
> > patch above as well ;))
> > 
> 
> Moving the embedded i2c busses to subsys_initcall was discussed here:
> http://lists.lm-sensors.org/pipermail/i2c/2008-June/004142.html. The
> i2c_gpio bus got mentioned, which is why I thought it had already been
> changed.

Thanks for the pointer!

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 197 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100528/5f9d5fe7/attachment.sig>
