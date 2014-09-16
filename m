From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 16 Sep 2014 14:53:09 -0700
Subject: [Patch v2] clk: qcom: Add IPQ8064 PLL required for USB
In-Reply-To: <1410901452-13519-1-git-send-email-agross@codeaurora.org>
References: <1410901452-13519-1-git-send-email-agross@codeaurora.org>
Message-ID: <20140916215309.GC22593@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/16, Andy Gross wrote:
> This patch adds the PLL0 that is required for the USB clocks to work properly.
> 
> Changes in v2: Correct table to only use pll0_vote
> 
> Signed-off-by: Andy Gross <agross@codeaurora.org>
> ---

Thanks, looks good.

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
