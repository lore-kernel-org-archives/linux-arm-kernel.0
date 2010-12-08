From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Wed, 8 Dec 2010 18:51:22 +0800
Subject: [PATCH 0/2] Common struct clk implementation, v8
In-Reply-To: <20101208103355.GK18244@pengutronix.de>
References: <1291774094.269634.503532219345.0.gpush@pororo>
	<20101208103355.GK18244@pengutronix.de>
Message-ID: <201012081851.23218.jeremy.kerr@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

> I would have expected that clk-common is an ancestor of clk-common-mx51.
> Currently it bases on v7(?) that doesn't have the spinlock.
> 
> BTW, I took a quick look over the patches in clk-common-mx51 and I think
> arch/arm/plat-mxc/include/mach/clock.h doesn't compile without
> CONFIG_USE_COMMON_STRUCT_CLK (because then there is no struct clk_mxc),
> so either you need more magic or just remove the #ifndef
> CONFIG_USE_COMMON_STRUCT_CLK.

Ah, I haven't pushed updates to the clk-common-mx51 branch yet, I'll get to 
this soon.

Cheers,


Jeremy
