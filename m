From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 7 Apr 2017 12:22:08 -0700
Subject: [PATCH 1/3] clk: zte: set CLK_SET_RATE_PARENT for a few zx296718
 clocks
In-Reply-To: <1490085503-15713-2-git-send-email-shawnguo@kernel.org>
References: <1490085503-15713-1-git-send-email-shawnguo@kernel.org>
 <1490085503-15713-2-git-send-email-shawnguo@kernel.org>
Message-ID: <20170407192208.GY7065@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/21, Shawn Guo wrote:
> From: Shawn Guo <shawn.guo@linaro.org>
> 
> To support VOU VGA display driver with different modes, we need to set
> flag for a few clocks, so that clk_set_rate() call in VOU driver can get
> VGA device desired pixel rate.
> 
> While at it, the divider between pll_vga and clk_vga gets corrected, as
> it's 1:1 instead of 1:2.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
