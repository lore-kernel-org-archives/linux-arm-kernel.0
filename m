From: khilman@ti.com (Kevin Hilman)
Date: Tue, 28 Jun 2011 07:54:57 -0700
Subject: [PATCH] OMAP1: enable GENERIC_IRQ_CHIP
In-Reply-To: <20110614115056.GT3352@atomide.com>
References: <1307491366-28793-1-git-send-email-khilman@ti.com>
	<20110614115056.GT3352@atomide.com>
Message-ID: <1309272897.6231.24.camel@vence>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-06-14 at 04:50 -0700, Tony Lindgren wrote:
> * Kevin Hilman <khilman@ti.com> [110607 16:58]:
> > OMAP1 needs this also since GPIO driver (common for all OMAPs) is
> > being converted to use generic IRQ chip.
> > 
> > Signed-off-by: Kevin Hilman <khilman@ti.com>
> 
> Maybe queue this together with your GPIO patches?
> 
> Acked-by: Tony Lindgren <tony@atomide.com>

Since this only touches arch/arm/plat-omap/*, this should probably go
through your tree, and I don't have any more GPIO fixes to queue for
this merge window.

Kevin
