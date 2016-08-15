From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 15 Aug 2016 12:10:24 -0700
Subject: [PATCH v1 02/14] clk: twl6040: Register the clock as
 of_clk_provider
In-Reply-To: <20160530085522.30398-3-peter.ujfalusi@ti.com>
References: <20160530085522.30398-1-peter.ujfalusi@ti.com>
 <20160530085522.30398-3-peter.ujfalusi@ti.com>
Message-ID: <20160815191024.GX361@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/30, Peter Ujfalusi wrote:
> In order ot be able to use the pdmclk clock via DT it need to be registered
> as of_clk_provide.
> Since the twl6040 clock driver does not have it's own DT node, use the
> parent's node for registering.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
