From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 1 Jul 2016 17:44:14 -0700
Subject: [PATCH V3 1/8] clk: introduce clk_core_enable_lock and
 clk_core_disable_lock functions
In-Reply-To: <1467279078-2330-2-git-send-email-aisheng.dong@nxp.com>
References: <1467279078-2330-1-git-send-email-aisheng.dong@nxp.com>
 <1467279078-2330-2-git-send-email-aisheng.dong@nxp.com>
Message-ID: <20160702004414.GJ27880@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/30, Dong Aisheng wrote:
> This can be useful when clock core wants to enable/disable clocks.
> Then we don't have to convert the struct clk_core to struct clk to call
> clk_enable/clk_disable which is a bit un-align with exist using.
> 
> And after introduce clk_core_{enable|disable}_lock, we can refine
> clk_enable and clk_disable a bit.
> 
> As well as clk_core_{enable|disable}_lock, we also added
> clk_core_{prepare|unprepare}_lock and clk_core_prepare_enable/
> clk_core_unprepare_disable for clock core to easily use.
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
