From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 13 Apr 2011 12:03:53 +0200
Subject: [PATCH v5 1/4] ARM: add GPMI support for imx23/imx28
In-Reply-To: <4DA5725A.9000106@freescale.com>
References: <1302675881-18862-1-git-send-email-b32955@freescale.com>
	<1302675881-18862-2-git-send-email-b32955@freescale.com>
	<20110413090304.GM18850@pengutronix.de>
	<4DA5725A.9000106@freescale.com>
Message-ID: <20110413100353.GP18850@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

> >>diff --git a/arch/arm/mach-mxs/mach-mx23evk.c b/arch/arm/mach-mxs/mach-mx23evk.c
> >IMHO adding the device to machines should be a seperate patch.
> Do I have to split the driver into two parts? one for ARM-KERNEL,
> and another for MTD?
> If I have to do it, I will split the driver.
I'm not sure I understood what you mean here. I havn't looked at the mtd
part of this series, but I think having:

 - ARM: mxs: add GPMI support for imx23/imx28
 - ARM: mxs: add gpmi device for mx2[38]evk
 - MTD: what
 - MTD: ever
 - MTD: is
 - MTD: needed

is OK.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
