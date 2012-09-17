From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 17 Sep 2012 11:38:13 +0000
Subject: [PATCH 00/34] i.MX multi-platform support
In-Reply-To: <20120917075138.GN6180@pengutronix.de>
References: <1347860103-4141-1-git-send-email-shawn.guo@linaro.org>
 <20120917075138.GN6180@pengutronix.de>
Message-ID: <201209171138.13327.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 17 September 2012, Sascha Hauer wrote:
> On Mon, Sep 17, 2012 at 01:34:29PM +0800, Shawn Guo wrote:
> > The series enables multi-platform support for imx.  Since the required
> > frameworks (clk, pwm) and spare_irq have already been adopted on imx,
> > the series is all about cleaning up mach/* headers.  Along with the
> > changes, arch/arm/plat-mxc gets merged into arch/arm/mach-imx.
> > 
> > It's based on a bunch of branches (works from others), Rob's initial
> > multi-platform series, Arnd's platform-data and smp_ops (Marc's) and
> > imx 3.7 material (Sascha and myself).
> > 
> > It's available on branch below.
> > 
> >   git://git.linaro.org/people/shawnguo/linux-2.6.git imx/multi-platform
> > 
> > It's been tested on imx5 and imx6, and only compile-tested on imx2 and
> > imx3, so testing on imx2/3 are appreciated.
> 
> Great work! This really pushes the i.MX architecture one step closer to
> a clean code base.

I agree, this series is wonderful, I thought it would take much longer
to get this far.

Two small comments on the last two patches from me, but overall I really
love it.

Acked-by: Arnd Bergmann <arnd@arndb.de>
