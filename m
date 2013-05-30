From: tony@atomide.com (Tony Lindgren)
Date: Thu, 30 May 2013 13:54:49 -0700
Subject: MUSB multiplatform work?
In-Reply-To: <20130530201854.GB6467@atomide.com>
References: <201305271702.09203.arnd@arndb.de>
 <20130528163548.GC28253@arwen.pp.htv.fi>
 <20130530201854.GB6467@atomide.com>
Message-ID: <20130530205448.GD6467@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [130530 13:25]:
> 
> TUSB we can make depend on ARMv7, the only implementation we have
> is for omap2420, which is ARMv6. This should solve the issue for
> ARMv7 multiplatform builds for now.

Sorry mean depend on !ARMv7. But thinking about it more, that does
not make much sense as it would break things for omap2plus_defconfig
at least which is multiplatform v6 and v7. For now TUSB can be made
to depend on MACH_NOKIA_N8X0. I doubt that anybody is using the add
on cards for H4 boards any longer..

Regards,

Tony
