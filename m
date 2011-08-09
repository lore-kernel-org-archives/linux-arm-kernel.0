From: tony@atomide.com (Tony Lindgren)
Date: Tue, 9 Aug 2011 06:16:22 -0700
Subject: OMAP3 kernels fail to build
In-Reply-To: <20110808113039.GB15134@n2100.arm.linux.org.uk>
References: <20110808110056.GA15134@n2100.arm.linux.org.uk>
	<4E3FC3EC.2010909@ti.com>
	<20110808113039.GB15134@n2100.arm.linux.org.uk>
Message-ID: <20110809131622.GS1866@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [110808 04:25]:
> On Mon, Aug 08, 2011 at 04:39:32PM +0530, Santosh wrote:
> > + Felipe,
> >
> > On Monday 08 August 2011 04:30 PM, Russell King - ARM Linux wrote:
> >> With CONFIG_ARCH_OMAP3=y and CONFIG_ARCH_OMAP4=n, I'm getting this:
> >>
> >> arch/arm/mach-omap2/built-in.o:(.data+0xf99c): undefined reference to `omap4430_phy_init'
> >> arch/arm/mach-omap2/built-in.o:(.data+0xf9a0): undefined reference to `omap4430_phy_exit'
> >> arch/arm/mach-omap2/built-in.o:(.data+0xf9a4): undefined reference to `omap4430_phy_power'
> >> arch/arm/mach-omap2/built-in.o:(.data+0xf9a8): undefined reference to `omap4430_phy_set_clk'
> >> arch/arm/mach-omap2/built-in.o:(.data+0xf9ac): undefined reference to `omap4430_phy_suspend'
> >>
> > I thought below patch was suppose to fix it.
> > https://patchwork.kernel.org/patch/963462/
> 
> So, the problem has been known about for around a month.  Yet the broken
> patch still went upstream.
> 
> vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
> IF IT IS KNOWN THAT A PATCH IS BROKEN IT MUST NOT BE SUBMITTED TO MAINLINE
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> We've seen other instances of that during this merge window, and Linus
> has responded thusly to these incidents:

Sorry I guess I just went into vacation mode and stopped applying patches.

Regards,

Tony
