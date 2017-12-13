From: davem@davemloft.net (David Miller)
Date: Wed, 13 Dec 2017 13:58:09 -0500 (EST)
Subject: [PATCH v3] net: ethernet: arc: fix error handling in
 emac_rockchip_probe
In-Reply-To: <20171211231338.5207-1-branislav@radocaj.org>
References: <20171211231338.5207-1-branislav@radocaj.org>
Message-ID: <20171213.135809.2249165364822346437.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Branislav Radocaj <branislav@radocaj.org>
Date: Tue, 12 Dec 2017 00:13:38 +0100

> If clk_set_rate() fails, we should disable clk before return.
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Changes since v2 [1]:
> * Merged with latest code changes
> 
> Changes since v1:
> Update made thanks to David's review, much appreciated David.
> * Improved inconsistent failure handling of clock rate setting
> * For completeness of usecase, added arc_emac_probe error handling
> 
> Signed-off-by: Branislav Radocaj <branislav@radocaj.org>

Applied.
