From: sboyd@kernel.org (Stephen Boyd)
Date: Mon, 27 Aug 2018 13:23:54 -0700
Subject: [PATCH] clk: sunxi-ng: sun50i: h6: Add 2x fixed post-divider to
 MMC module clocks
In-Reply-To: <20180820134013.16527-1-icenowy@aosc.io>
References: <20180820134013.16527-1-icenowy@aosc.io>
Message-ID: <153540143478.129321.8502068006504989469@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Icenowy Zheng (2018-08-20 06:40:13)
> On the H6, the MMC module clocks are fixed in the new timing mode,
> i.e. they do not have a bit to select the mode. These clocks have
> a 2x divider somewhere between the clock and the MMC module.
> 
> To be consistent with other SoCs supporting the new timing mode,
> we model the 2x divider as a fixed post-divider on the MMC module
> clocks.
> 
> This patch adds the post-dividers to the MMC clocks, following the
> approach on A64.
> 
> Fixes: 542353ea ("clk: sunxi-ng: add support for the Allwinner H6 CCU")

This commit doesn't exist. Did you mean:

524353ea48

instead?
