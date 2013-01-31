From: tony@atomide.com (Tony Lindgren)
Date: Thu, 31 Jan 2013 08:00:02 -0800
Subject: Failure to boot...
In-Reply-To: <510A82FE.6050803@ti.com>
References: <20130131092024.GN2637@n2100.arm.linux.org.uk>
 <20130131104044.GO2637@n2100.arm.linux.org.uk>
 <510A6877.9080307@ti.com>
 <20130131130437.GP2637@n2100.arm.linux.org.uk>
 <510A78E1.8010308@ti.com>
 <20130131141320.GQ2637@n2100.arm.linux.org.uk>
 <20130131141635.GR2637@n2100.arm.linux.org.uk>
 <510A7D9F.7040507@ti.com>
 <20130131142758.GS2637@n2100.arm.linux.org.uk>
 <510A82FE.6050803@ti.com>
Message-ID: <20130131160000.GW15361@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [130131 06:45]:
> On Thursday 31 January 2013 07:57 PM, Russell King - ARM Linux wrote:
> >>>
> >>># 13 Jan 2013: Update for OMAP moving to multiplatform
> >>>CONFIG_ARCH_MULTIPLATFORM=y
> >>>CONFIG_ARCH_MULTI_V7=y
> >>>
> >>>don't fix it either, it needs more options defined...

Just trying to figure out what was the missing entry in case
others have the same problem.

In addition to the ones above, I had also CONFIG_ARCH_OMAP2PLUS=y
listed in my comments. Did you also need something else added
manually?

Regards,

Tony
