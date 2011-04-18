From: tony@atomide.com (Tony Lindgren)
Date: Mon, 18 Apr 2011 14:33:36 +0300
Subject: [RFC PATCH v2] Consolidate SRAM support
In-Reply-To: <20110418085259.GA26044@n2100.arm.linux.org.uk>
References: <20110415130607.GM1611@n2100.arm.linux.org.uk>
	<20110418085259.GA26044@n2100.arm.linux.org.uk>
Message-ID: <20110418113335.GL12272@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [110418 11:50]:
> This is the second revision of this patch.  I've not moved it out of
> ARM yet as I haven't had a positive response from SH yet.
> 
> It's now called pv_pool (for phys/virt pool) rather than sram_pool,
> and I've included MXC's iram support in this.  Hopefully, if OMAP can
> remove the FB stuff from SRAM we can clean the OMAP bits up a little
> more.  Neither have I sorted out the last reference to omap_sram_ceil.
> Some comments from OMAP people on what's going on there would be good.

I believe the omap_sram_ceil should also disappear with the omapfb
SRAM patch.

Tony
