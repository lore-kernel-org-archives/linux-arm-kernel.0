From: mgr@pengutronix.de (Michael Grzeschik)
Date: Tue, 17 Aug 2010 14:37:57 +0200
Subject: [PATCH 2/2] i.MX35: Add EPIT support
In-Reply-To: <20100817120152.GD9631@jasper.tkos.co.il>
References: <1282044218-14809-1-git-send-email-m.grzeschik@pengutronix.de>
	<1282044218-14809-3-git-send-email-m.grzeschik@pengutronix.de>
	<20100817120152.GD9631@jasper.tkos.co.il>
Message-ID: <20100817123757.GA16061@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 17, 2010 at 03:01:52PM +0300, Baruch Siach wrote:
> Hi Michael, Sascha,
> 
> On Tue, Aug 17, 2010 at 01:23:38PM +0200, Michael Grzeschik wrote:
> > From: Sascha Hauer <s.hauer@pengutronix.de>
> > 
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> > ---
> 
> [snip]
> 
> > diff --git a/arch/arm/plat-mxc/include/mach/common.h 
> > b/arch/arm/plat-mxc/include/mach/common.h
> > index 2941472..7a1e1f8 100644
> > --- a/arch/arm/plat-mxc/include/mach/common.h
> > +++ b/arch/arm/plat-mxc/include/mach/common.h
> > @@ -32,6 +32,7 @@ extern void mx31_init_irq(void);
> >  extern void mx35_init_irq(void);
> >  extern void mx51_init_irq(void);
> >  extern void mxc91231_init_irq(void);
> > +extern void epit_timer_init(struct clk *timer_clk, void __iomem *base, int irq);
> >  extern void mxc_timer_init(struct clk *timer_clk, void __iomem *, int);
> >  extern int mx1_clocks_init(unsigned long fref);
> >  extern int mx21_clocks_init(unsigned long lref, unsigned long fref);
> 
> This hunk should probably be moved to the previous patch, where 
> epit_timer_init is defined.
Yes, this should move. I will wait some more time
for more feedback and post v2 Version afterwards.

Michael

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
