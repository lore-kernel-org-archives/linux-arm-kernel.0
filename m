From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 18 Feb 2011 11:01:58 +0100
Subject: [PATCH RESEND 3/4] ARM: imx53_loco: add i2c device support
In-Reply-To: <20110218085940.GA2086@b20223-02.ap.freescale.net>
References: <1298003777-7687-1-git-send-email-richard.zhao@freescale.com>
	<1298003777-7687-3-git-send-email-richard.zhao@freescale.com>
	<20110218084533.GV22310@pengutronix.de>
	<20110218085940.GA2086@b20223-02.ap.freescale.net>
Message-ID: <20110218100158.GM24426@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 18, 2011 at 04:59:41PM +0800, Richard Zhao wrote:
> Hi Uwe,
> 
> On Fri, Feb 18, 2011 at 09:45:33AM +0100, Uwe Kleine-K?nig wrote:
> > On Fri, Feb 18, 2011 at 12:36:16PM +0800, Richard Zhao wrote:
> > > Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> > > 
> > > diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
> > > index 10b6008..abea297 100644
> > > --- a/arch/arm/mach-mx5/Kconfig
> > > +++ b/arch/arm/mach-mx5/Kconfig
> > > @@ -146,6 +146,7 @@ config MACH_MX53_LOCO
> > >  	bool "Support MX53 LOCO platforms"
> > >  	select SOC_IMX53
> > >  	select IMX_HAVE_PLATFORM_IMX_UART
> > > +	select IMX_HAVE_PLATFORM_IMX_I2C
> > please keep these sorted alphabetically
> ok. I will move it up by one line.

Fixed while applying.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
