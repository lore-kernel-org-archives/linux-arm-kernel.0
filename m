From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 16 Sep 2016 16:04:12 -0700
Subject: [PATCH 3/3] clk: sunxi-ng: sun6i-a31: Fix register offset for
 mipi-csi clk
In-Reply-To: <20160915065740.13664-4-wens@csie.org>
References: <20160915065740.13664-1-wens@csie.org>
 <20160915065740.13664-4-wens@csie.org>
Message-ID: <20160916230412.GU7243@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/15, Chen-Yu Tsai wrote:
> The register offset for the mipi-csi clk is off by 4, a copy paste
> error from the mipi-dsi clk.
> 
> Fixes: c6e6c96d8fa6 ("clk: sunxi-ng: Add A31/A31s clocks")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
