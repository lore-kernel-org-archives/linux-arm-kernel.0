From: tony@atomide.com (Tony Lindgren)
Date: Fri, 31 May 2013 10:52:30 -0700
Subject: MUSB multiplatform work?
In-Reply-To: <20130531040004.GA7879@arwen.pp.htv.fi>
References: <201305271702.09203.arnd@arndb.de>
 <20130528163548.GC28253@arwen.pp.htv.fi>
 <20130530201854.GB6467@atomide.com>
 <20130530205448.GD6467@atomide.com>
 <20130531040004.GA7879@arwen.pp.htv.fi>
Message-ID: <20130531175228.GP6467@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Balbi <balbi@ti.com> [130530 21:06]:
> On Thu, May 30, 2013 at 01:54:49PM -0700, Tony Lindgren wrote:
> > * Tony Lindgren <tony@atomide.com> [130530 13:25]:
> > > 
> > > TUSB we can make depend on ARMv7, the only implementation we have
> > > is for omap2420, which is ARMv6. This should solve the issue for
> > > ARMv7 multiplatform builds for now.
> > 
> > Sorry mean depend on !ARMv7. But thinking about it more, that does
> > not make much sense as it would break things for omap2plus_defconfig
> > at least which is multiplatform v6 and v7. For now TUSB can be made
> > to depend on MACH_NOKIA_N8X0. I doubt that anybody is using the add
> > on cards for H4 boards any longer..
> 
> could also be made to depend on BROKEN. I don't think anyone *really*
> cares about that glue layer other than the very few in the world who
> still like the nostalgic feeling of booting current linux releases on
> n8x0 devices.

Unfortunately that's the best test case we have for GPMC and DMA stress
testing so it's good to keep around.

And n8x0 is still quite usable general purpose pocket computer with
keyboard and WLAN and tons of storage :)

Regards,

Tony
