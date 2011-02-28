From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 28 Feb 2011 15:19:02 +0100
Subject: [PATCH V3 1/4] ARM: imx53_loco: add esdhc device support
In-Reply-To: <AANLkTimTsv1jsvX8Eq9EttU32O0sJ-8yj-SGadx9gwLD@mail.gmail.com>
References: <1298892315-23386-1-git-send-email-Hong-Xing.Zhu@freescale.com>
	<AANLkTin1U=B3xnp0UGK_2iHK2k=o4Tda=6NzyoLFgUAv@mail.gmail.com>
	<AANLkTimTsv1jsvX8Eq9EttU32O0sJ-8yj-SGadx9gwLD@mail.gmail.com>
Message-ID: <20110228141902.GD15532@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> >> Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> >> ---
> >> ?arch/arm/mach-mx5/Kconfig ? ? ? ? ? | ? ?1 +
> >> ?arch/arm/mach-mx5/board-mx53_loco.c | ? ?2 ++
> >> ?2 files changed, 3 insertions(+), 0 deletions(-)
> >
> > I think this patch should be the last one of the series.
> Yes, but I don't think it matter much.

It will if you bisect and end up here without the clock patch, no?

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110228/caf7af73/attachment.sig>
