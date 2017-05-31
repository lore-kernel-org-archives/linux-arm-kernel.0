From: tony@atomide.com (Tony Lindgren)
Date: Wed, 31 May 2017 15:20:22 -0700
Subject: [PATCHv4 0/6] ARM: OMAP2+: preparation for clk/clkctrl support
In-Reply-To: <20170531195339.GL3730@atomide.com>
References: <1496242803-6101-1-git-send-email-t-kristo@ti.com>
 <20170531195339.GL3730@atomide.com>
Message-ID: <20170531222021.GM3730@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [170531 12:57]:
> * Tero Kristo <t-kristo@ti.com> [170531 08:03]:
> > Hi,
> > 
> > This series is evolution of the v3b of the same series:
> > https://www.spinics.net/lists/arm-kernel/msg584344.html
> > 
> > Changes compared to v3b:
> > 
> > - Added patch #3 which stores the physical address for PRCM instances
> >   in addition to the virtual addresses
> > - Fixed patch #5 to use physical base address for xlate instead of
> >   the OMAP2_L4_IO_ADDRESS hack
> > - Dropped unnecessary device node passing from patch #6 which makes
> >   the code slightly more readable also
> 
> I gave this series a quick test with no other changes and
> noticed that n8x0 stopped booting. Other than that looks
> pretty good to me.

Sorry that was a false alert, n8x0 is booting just fine.
It's the loading of kernel over USB that's flakey for me
again..

Regards,

Tony
