From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Sat, 27 Aug 2011 13:14:26 +0200
Subject: [GIT PULL] i.MX cleanups for next
In-Reply-To: <201108261923.26398.arnd@arndb.de>
References: <20110823115609.GJ31404@pengutronix.de>
	<20110826082558.GC7526@pengutronix.de>
	<201108261923.26398.arnd@arndb.de>
Message-ID: <20110827111426.GJ31404@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 26, 2011 at 07:23:26PM +0200, Arnd Bergmann wrote:
> On Friday 26 August 2011, Sascha Hauer wrote:
> > Shawn Guo (7):
> >       arm/mxc: do not use gpio_to_irq() for static initializers
> >       gpio/mxc: add .to_irq for gpio chip
> >       arm/mxc: use gpiolib helper for gpio_to_irq
> >       gpio/mxc: move irq_to_gpio() into gpio-mxc driver
> >       arm/mxc: move IMX_GPIO_NR into mach/hardware.h
> >       gpio/mxs: move irq_to_gpio() into gpio-mxs driver
> >       arm/mxs: move MXS_GPIO_NR into mach/mxs.h
> 
> I got conflicts between these patches and the gpio cleanups in Russell's
> gpio branch. For now, I have reverted Shawn's patches so that we
> can get build coverage of the rest in linux-next without annoying
> Stephen too much.

I don't know the situation exactly at the moment, but I remember that
Shawn originally sent the patches based on rmks patchset. I reworked
them to fit onto mainline to be able to apply them and decided that
the conflicts were easy enough to solve upstream.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
