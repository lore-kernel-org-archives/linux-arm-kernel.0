From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 15 Sep 2012 20:14:37 +0000
Subject: [PATCH 17/24] ARM: OMAP: use __iomem pointers for MMIO
In-Reply-To: <20120915181057.GH4521@atomide.com>
References: <1347658492-11608-1-git-send-email-arnd@arndb.de>
 <1347658492-11608-18-git-send-email-arnd@arndb.de>
 <20120915181057.GH4521@atomide.com>
Message-ID: <201209152014.37989.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 15 September 2012, Tony Lindgren wrote:
> With my patches, this is now all omap1 specific and
> moved to arch/arm/mach-omap1/include/mach/hardware.h.
> It's probably easiest to just update this patch on
> top of the hardware.h changes I've done.

Yes, sounds good. Do you want to send a patch for that
and let me drop this one then?

	Arnd
