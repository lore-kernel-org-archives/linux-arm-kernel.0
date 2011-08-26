From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 26 Aug 2011 19:23:26 +0200
Subject: [GIT PULL] i.MX cleanups for next
In-Reply-To: <20110826082558.GC7526@pengutronix.de>
References: <20110823115609.GJ31404@pengutronix.de>
	<20110826082558.GC7526@pengutronix.de>
Message-ID: <201108261923.26398.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 26 August 2011, Sascha Hauer wrote:
> Shawn Guo (7):
>       arm/mxc: do not use gpio_to_irq() for static initializers
>       gpio/mxc: add .to_irq for gpio chip
>       arm/mxc: use gpiolib helper for gpio_to_irq
>       gpio/mxc: move irq_to_gpio() into gpio-mxc driver
>       arm/mxc: move IMX_GPIO_NR into mach/hardware.h
>       gpio/mxs: move irq_to_gpio() into gpio-mxs driver
>       arm/mxs: move MXS_GPIO_NR into mach/mxs.h

I got conflicts between these patches and the gpio cleanups in Russell's
gpio branch. For now, I have reverted Shawn's patches so that we
can get build coverage of the rest in linux-next without annoying
Stephen too much.

Shawn, can you please have a look for a better resolution here?
Maybe it's best of you rebase these patches on top of Russell's tree
and let him merge them.

	Arnd
