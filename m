From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 10 Dec 2013 20:21:44 +0000
Subject: OMAP still fails - usb phy stuff
In-Reply-To: <20131210202014.GE2464@saruman.home>
References: <20131210130926.GZ4360@n2100.arm.linux.org.uk>
 <20131210183809.GL13171@atomide.com> <20131210192508.GB2464@saruman.home>
 <20131210201639.GD2464@saruman.home> <20131210202014.GE2464@saruman.home>
Message-ID: <20131210202143.GD4360@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 10, 2013 at 02:20:14PM -0600, Felipe Balbi wrote:
> On Tue, Dec 10, 2013 at 02:16:40PM -0600, Felipe Balbi wrote:
> > diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> > index a344f3d..d8b1a9a 100644
> > --- a/drivers/phy/Kconfig
> > +++ b/drivers/phy/Kconfig
> > @@ -24,9 +24,9 @@ config PHY_EXYNOS_MIPI_VIDEO
> >  config OMAP_USB2
> >  	tristate "OMAP USB2 PHY Driver"
> >  	depends on ARCH_OMAP2PLUS
> > +	depends on OMAP_CONTROL_USB
> >  	select GENERIC_PHY
> >  	select USB_PHY
> > -	select OMAP_CONTROL_USB
> >  	help
> >  	  Enable this to support the transceiver that is part of SOC. This
> >  	  driver takes care of all the PHY functionality apart from comparator.
> > 
> > i'll send it as a proper patch now.
> 
> Russell, should I add your Reported-by ? If so, which email do you
> prefer to be used ?

I always prefer rmk+kernel at arm.linux.org.uk in git commits.  Thanks
for asking.
