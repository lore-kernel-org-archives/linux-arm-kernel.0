From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Fri, 20 Dec 2013 23:55:30 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gTUFJTlRBSU5FUlM6IHRha2UgbWFpbnRhaW5lcnNoaXAg?=
 =?UTF-8?B?Zm9yIEVuZXJneSBNaWNybyBlZm0zMiBTb0Nz?=
In-Reply-To: <1387568343-8754-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1387568343-8754-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1387569330.616105313@f421.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
...
> I think this can best go in via armsoc, but needs acks for clk, clocksource,
> spi and tty/serial.
...
>  MAINTAINERS | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 95648eb..28c69a6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -867,6 +867,21 @@ S:	Maintained
>  F:	arch/arm/mach-ebsa110/
>  F:	drivers/net/ethernet/amd/am79c961a.*
>  
> +ARM/ENERGY MICRO (SILICON LABS) EFM32 SUPPORT
> +M:	Uwe Kleine-K?nig <kernel@pengutronix.de>
> +L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
> +S:	Maintained
> +F:	arch/arm/boot/dts/efm32*
> +F:	arch/arm/configs/efm32_defconfig
> +F:	arch/arm/include/debug/efm32.S
> +F:	arch/arm/mach-efm32/
> +F:	drivers/clk/clk-efm32gg.c
> +F:	drivers/clocksource/time-efm32.c
> +F:	drivers/spi/spi-efm32.c
> +F:	drivers/tty/serial/efm32-uart.c
> +F:	include/dt-bindings/clock/efm32-cmu.h
> +F:	include/linux/platform_data/efm32-*

Maybe "N" keyword with "efm32" is better here?

---
