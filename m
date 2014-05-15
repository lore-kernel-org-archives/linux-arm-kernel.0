From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 15 May 2014 22:36:12 +0200
Subject: [PATCH v3 1/4] ARM: Kirkwood: Add board file for netxbig LEDs
In-Reply-To: <9089389.h3psAgEGtm@wuerfel>
References: <1400163836-9831-1-git-send-email-andrew@lunn.ch>
 <1400163836-9831-2-git-send-email-andrew@lunn.ch>
 <9089389.h3psAgEGtm@wuerfel>
Message-ID: <20140515203612.GC10407@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 15, 2014 at 04:38:43PM +0200, Arnd Bergmann wrote:
> On Thursday 15 May 2014 16:23:42 Andrew Lunn wrote:
> > diff --git a/arch/arm/mach-mvebu/board-netxbig.c b/arch/arm/mach-mvebu/board-netxbig.c
> > new file mode 100644
> > index 000000000000..e6f2f547b1c7
> > --- /dev/null
> > +++ b/arch/arm/mach-mvebu/board-netxbig.c
> > 
> 
> I'd rather see these tables as part of the netxbig led driver in a
> separate file, but if we keep it here, can you rename the file to
> kirkwood-netxbig-led.c? We are not really doing board files any
> more, and this isn't one.

I will rename it. Simon has said he hopes to test on real hardware
soon, so once i have the results i will respin the patch set.

Adding a DT binding to the LED driver is probably a task for next
cycle.

	Andrew
