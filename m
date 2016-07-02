From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 1 Jul 2016 17:45:14 -0700
Subject: [PATCH V3 8/8] clk: imx7d: only enable minimum required clocks
In-Reply-To: <1467279078-2330-9-git-send-email-aisheng.dong@nxp.com>
References: <1467279078-2330-1-git-send-email-aisheng.dong@nxp.com>
 <1467279078-2330-9-git-send-email-aisheng.dong@nxp.com>
Message-ID: <20160702004514.GQ27880@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/30, Dong Aisheng wrote:
> Formerly clk core does not support imx7d clock type well that all
> its clock operations requires the parent clock on.
> Therefore we enabled all clocks by default in clock driver
> initialization for other module clocks operate well.
> 
> After patch 'clk: imx7d: using api with flag CLK_OPS_PARENT_ENABLE',
> clk core can handle such clock type well, so we don't have to enable
> them all by default anymore. Instead, we only enable a minimum required
> set of clocks.
> 
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
