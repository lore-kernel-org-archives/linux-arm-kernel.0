From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 1 Oct 2009 18:37:53 +0200
Subject: [PATCH 1/4] i2c: imx: check busy bit when START/STOP
In-Reply-To: <4e090d470910010754r1ebc4455u6220ccfd803491b0@mail.gmail.com>
References: <1254359613-21210-1-git-send-email-linuxzsc@gmail.com>
	<4e090d470910010103o611d9fb2t3acf93632216fc88@mail.gmail.com>
	<20091001083831.GD27039@pengutronix.de>
	<4e090d470910010211k4ce78763i1a5163ec6ea57fe8@mail.gmail.com>
	<20091001095239.GE27039@pengutronix.de>
	<4e090d470910010754r1ebc4455u6220ccfd803491b0@mail.gmail.com>
Message-ID: <20091001163753.GA20103@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > Ah, so 'make the driver work on i.MX51' is a good statement which should
> > be part of the commit message.
> Well, maybe I can mention it.
> But I think the good point is to present what you modified, not the side effect.

It is not the side effect but the intention :) As no code is changed without a
need, the reason really should be in the patch description.

> Yes. But I don't have multi-master system. So I can't say that.
> The code is just taken from Freescale latest code. Without it, It
> could also cause a device error. I forget the details.  Anyway, it
> doesn't make anything wrong.

Do you know where the details are explained?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091001/c5b3f439/attachment.sig>
