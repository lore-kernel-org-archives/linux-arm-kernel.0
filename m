From: tony@atomide.com (Tony Lindgren)
Date: Thu, 3 Dec 2015 08:07:13 -0800
Subject: [PATCH 1/2] clk: ti: Add support for dm814x ADPLL
In-Reply-To: <1449106504-7645-2-git-send-email-tony@atomide.com>
References: <1449106504-7645-1-git-send-email-tony@atomide.com>
 <1449106504-7645-2-git-send-email-tony@atomide.com>
Message-ID: <20151203160712.GM23396@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [151202 17:36]:
> On dm814x we have 13 ADPLLs with 3 to 4 outputs on each. The
> ADPLLs have several dividers and muxes controlled by a shared
> control register for each PLL.
> 
> Note that for the clocks to work as device drivers for booting on
> dm814x, this patch depends on "ARM: OMAP2+: Change core_initcall
> levels to postcore_initcall".
> 
> Also note that this patch does not implement clk_set_rate,
> that will be posted later on when available.

Mike & Stephen, after review, can we have this patch alone in an
immutable branch against v4.4-rc1 that I can merge in too?

Also, the dts changes I need to queue separately FYI to avoid merge
conflicts.

Regards,

Tony
