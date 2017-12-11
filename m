From: davem@davemloft.net (David Miller)
Date: Mon, 11 Dec 2017 12:13:13 -0500 (EST)
Subject: [PATCH v2] net: ethernet: arc: fix error handling in
 emac_rockchip_probe
In-Reply-To: <20171209115133.19205-1-branislav@radocaj.org>
References: <20171209115133.19205-1-branislav@radocaj.org>
Message-ID: <20171211.121313.2095634506477592012.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Branislav Radocaj <branislav@radocaj.org>
Date: Sat,  9 Dec 2017 12:51:33 +0100

> If clk_set_rate() fails, we should disable clk before return.
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Branislav Radocaj <branislav@radocaj.org>
> ---
> 
> Changes since v2:
> * Improved inconsistent failure handling of clock rate setting
> * For completeness of usecase, added arc_emac_probe error handling

This doesn't apply to any of my trees.
