From: tony@atomide.com (Tony Lindgren)
Date: Sun, 16 Sep 2012 13:38:50 -0700
Subject: [PATCH 17/24] ARM: OMAP: use __iomem pointers for MMIO
In-Reply-To: <201209152014.37989.arnd@arndb.de>
References: <1347658492-11608-1-git-send-email-arnd@arndb.de>
 <1347658492-11608-18-git-send-email-arnd@arndb.de>
 <20120915181057.GH4521@atomide.com>
 <201209152014.37989.arnd@arndb.de>
Message-ID: <20120916203850.GI4521@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Arnd Bergmann <arnd@arndb.de> [120915 13:15]:
> On Saturday 15 September 2012, Tony Lindgren wrote:
> > With my patches, this is now all omap1 specific and
> > moved to arch/arm/mach-omap1/include/mach/hardware.h.
> > It's probably easiest to just update this patch on
> > top of the hardware.h changes I've done.
> 
> Yes, sounds good. Do you want to send a patch for that
> and let me drop this one then?

Yes I can pick this one and update it against one of my
branches to avoid merge conflicts.

Regards,

Tony
