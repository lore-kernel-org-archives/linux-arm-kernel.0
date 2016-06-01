From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 1 Jun 2016 14:48:15 -0700
Subject: [PATCH] vexpress/spc: Remove CLK_IS_ROOT
In-Reply-To: <1461116215-1517-1-git-send-email-sboyd@codeaurora.org>
References: <1461116215-1517-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20160601214815.GA28218@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/19, Stephen Boyd wrote:
> This flag is a no-op now (see commit 47b0eeb3dc8a "clk: Deprecate
> CLK_IS_ROOT", 2016-02-02) so remove it.
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---

Applied to clk-fixes

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
