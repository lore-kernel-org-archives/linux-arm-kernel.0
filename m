From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 19 Jan 2012 11:24:36 +0800
Subject: [PATCH] arm: mx28: check for gated clocks when setting saif
 divider
In-Reply-To: <20111117011833.GD14656@S2100-06.ap.freescale.net>
References: <1315650583-4793-1-git-send-email-w.sang@pengutronix.de>
 <20111116132222.GD2596@pengutronix.de>
 <65EE16ACC360FA4D99C96DC085B3F7722D4E65@039-SN1MPN1-002.039d.mgd.msft.net>
 <20111116135125.GE2596@pengutronix.de>
 <20111117011833.GD14656@S2100-06.ap.freescale.net>
Message-ID: <20120119032434.GA20865@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 17, 2011 at 09:18:34AM +0800, Shawn Guo wrote:
> On Wed, Nov 16, 2011 at 02:51:26PM +0100, Wolfram Sang wrote:
...
> > I chose this approach because this is the common pattern
> > in all other clocks. There might be a better way of handling this, but
> > then we'd need to adapt all other clocks as well. What we definately
> > should not have is one kind of handling the 'already enabled' case for a
> > few clocks and another kind for others.
> > 
> What about leaving it as it is for now, and try to consolidate when
> we rework the code for common clock framework migration?
> 
I confirmed this patch is needed and decide to apply it immediately
without waiting for common clock consolidation effort.

PS. I'm changing the subject prefix to "ARM: mx28: ...".

-- 
Regards,
Shawn
