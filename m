From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 15 Aug 2016 15:48:36 -0700
Subject: [PATCH] clk: gxbb: add MMC gate clocks, and expose for DT
In-Reply-To: <20160802214011.19077-1-khilman@baylibre.com>
References: <20160802214011.19077-1-khilman@baylibre.com>
Message-ID: <20160815224836.GS361@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/02, Kevin Hilman wrote:
> Add the SD/eMMC gate clocks and expose them for use by DT.
> 
> While at it, also explose FCLK_DIV2 since this is one of the input
> clocks to the mux internal to each of the SD/eMMC blocks.
> 
> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
> ---

Applied to clk-meson-gxbb and merged into clk-next.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
