From: yegor_sub1@visionsystems.de (Yegor Yefremov)
Date: Mon, 11 Jun 2012 16:29:03 +0200
Subject: am33xx: pin modes
In-Reply-To: <20120611140417.GC12766@atomide.com>
References: <4FD5E268.7030105@visionsystems.de>
 <1BAFE6F6C881BF42822005164F1491C33EA1E6F0@DBDE01.ent.ti.com>
 <20120611140417.GC12766@atomide.com>
Message-ID: <4FD600AF.9070204@visionsystems.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 11.06.2012 16:04, schrieb Tony Lindgren:
> * Hebbar, Gururaja <gururaja.hebbar@ti.com> [120611 06:48]:
>> On Mon, Jun 11, 2012 at 17:49:52, Yegor Yefremov wrote:
>>> I'm working with Koen's repo (https://github.com/koenkooi/linux.git) and have a question. There are two places, where pin's function is defined:
>>>
>>>
>>> arch/arm/mach-omap2/mux33xx.c:
>>> static struct omap_mux __initdata am33xx_muxmodes[] = {
>>> /**/    _AM33XX_MUXENTRY(GPMC_AD0, 0,
>>>                 "gpmc_ad0", "mmc1_dat0", NULL, NULL,
>>>                 NULL, NULL, NULL, "gpio1_0"),
>>>
>> This is the big AM33XX pin mux super set table. Here, Entire Mux entries for AM335x SOC
>> are defined.
> Please note that we're moving to the generic pinctrl framework,
> and using device tree and pinctrl-single driver. So the old style
> pinmux data or board-*.c files will not get merged upstream.

O.K. Where can I see examples?

Best regards,
Yegor
