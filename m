From: tony@atomide.com (Tony Lindgren)
Date: Thu, 24 Mar 2011 10:59:45 -0700
Subject: Updated mach-types update
In-Reply-To: <20110320114137.GD16646@n2100.arm.linux.org.uk>
References: <20110320110322.GC16646@n2100.arm.linux.org.uk>
	<20110320114137.GD16646@n2100.arm.linux.org.uk>
Message-ID: <20110324175945.GV2811@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [110320 04:39]:
> On Sun, Mar 20, 2011 at 11:03:22AM +0000, Russell King - ARM Linux wrote:
> 
> Note that OMAP references machine_is_omap2evm() yet this has never been
> merged.
> 
> arch/arm/plat-omap/include/plat/uncompress.h:
> 
>                 DEBUG_LL_OMAP2(1, omap2evm);
> 
> so this entry needs to be removed.

Hmm looks like we have LCD support and ASoC support for it, but no
board :)

Anybody working with this board?

If so, please send patches for the related board-*.c support ASAP.
Otherwise let's plan on deleting the related support.

Regards,

Tony
