From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 1 Jul 2016 17:45:11 -0700
Subject: [PATCH V3 7/8] clk: imx7d: using api with flag
 CLK_OPS_PARENT_ENABLE
In-Reply-To: <1467279078-2330-8-git-send-email-aisheng.dong@nxp.com>
References: <1467279078-2330-1-git-send-email-aisheng.dong@nxp.com>
 <1467279078-2330-8-git-send-email-aisheng.dong@nxp.com>
Message-ID: <20160702004511.GP27880@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/30, Dong Aisheng wrote:
> i.MX7D requires all clocks operations including enable/disable,
> rate change and re-parent with its parent clock on.
> Changing to the correct APIs to tell clk core such requirement.
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
