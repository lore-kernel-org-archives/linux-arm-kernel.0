From: olof@lixom.net (Olof Johansson)
Date: Sun, 22 Dec 2013 12:04:39 -0800
Subject: [PATCH v2] MAINTAINERS: take maintainership for Energy Micro
 efm32 SoCs
In-Reply-To: <1387570919-13627-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1387569330.616105313@f421.i.mail.ru>
 <1387570919-13627-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20131222200439.GA11214@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 20, 2013 at 09:21:59PM +0100, Uwe Kleine-K?nig wrote:
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

Applied, thanks.

-Olof
