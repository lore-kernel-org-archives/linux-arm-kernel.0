From: b32955@freescale.com (Huang Shijie)
Date: Wed, 13 Apr 2011 18:49:14 +0800
Subject: [PATCH v5 1/4] ARM: add GPMI support for imx23/imx28
In-Reply-To: <20110413100353.GP18850@pengutronix.de>
References: <1302675881-18862-1-git-send-email-b32955@freescale.com>
	<1302675881-18862-2-git-send-email-b32955@freescale.com>
	<20110413090304.GM18850@pengutronix.de>
	<4DA5725A.9000106@freescale.com>
	<20110413100353.GP18850@pengutronix.de>
Message-ID: <4DA57FAA.7030309@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi:
> Hello,
>
>>>> diff --git a/arch/arm/mach-mxs/mach-mx23evk.c b/arch/arm/mach-mxs/mach-mx23evk.c
>>> IMHO adding the device to machines should be a seperate patch.
>> Do I have to split the driver into two parts? one for ARM-KERNEL,
>> and another for MTD?
>> If I have to do it, I will split the driver.
> I'm not sure I understood what you mean here. I havn't looked at the mtd
> part of this series, but I think having:
>
>   - ARM: mxs: add GPMI support for imx23/imx28
>   - ARM: mxs: add gpmi device for mx2[38]evk
>   - MTD: what
>   - MTD: ever
>   - MTD: is
>   - MTD: needed
>
> is OK.
>
ok, thanks.

Best Regards
Huang Shijie
> Best regards
> Uwe
>
