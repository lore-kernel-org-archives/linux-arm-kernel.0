From: mturquette@linaro.org (Mike Turquette)
Date: Sun, 22 Dec 2013 12:54:14 -0800
Subject: [PATCH v2] MAINTAINERS: take maintainership for Energy Micro
 efm32 SoCs
In-Reply-To: <1387570919-13627-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1387569330.616105313@f421.i.mail.ru>
 <1387570919-13627-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20131222205414.22761.9778@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Uwe Kleine-K?nig (2013-12-20 12:21:59)
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Acked-by: Mark Brown <broonie@linaro.org>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
> 
> On Fri, Dec 20, 2013 at 11:55:30PM +0400, Alexander Shiyan wrote:
> > [...]
> > > +F: arch/arm/boot/dts/efm32*
> > > +F: arch/arm/configs/efm32_defconfig
> > > +F: arch/arm/include/debug/efm32.S
> > > +F: arch/arm/mach-efm32/
> > > +F: drivers/clk/clk-efm32gg.c
> > > +F: drivers/clocksource/time-efm32.c
> > > +F: drivers/spi/spi-efm32.c
> > > +F: drivers/tty/serial/efm32-uart.c
> > > +F: include/dt-bindings/clock/efm32-cmu.h
> > > +F: include/linux/platform_data/efm32-*
> > 
> > Maybe "N" keyword with "efm32" is better here?
> ah, didn't know about that. Nice.
> 
> So the changes since v1 are:
>  - use N: efm32
>  - add acks from Greg and Mark
>    I assume it's ok to keep them for v2 assuming they mean them being OK with
>    me maintaining the efm32 stuff and not the way to express that in
>    MAINTAINERS.

Ack for the clock driver.

Mike

> 
> Thanks
> Uwe
> 
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 95648eb..6ea1fb2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -867,6 +867,12 @@ S: Maintained
>  F:     arch/arm/mach-ebsa110/
>  F:     drivers/net/ethernet/amd/am79c961a.*
>  
> +ARM/ENERGY MICRO (SILICON LABS) EFM32 SUPPORT
> +M:     Uwe Kleine-K?nig <kernel@pengutronix.de>
> +L:     linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
> +S:     Maintained
> +N:     efm32
> +
>  ARM/EZX SMARTPHONES (A780, A910, A1200, E680, ROKR E2 and ROKR E6)
>  M:     Daniel Ribeiro <drwyrm@gmail.com>
>  M:     Stefan Schmidt <stefan@openezx.org>
> -- 
> 1.8.5.1
> 
