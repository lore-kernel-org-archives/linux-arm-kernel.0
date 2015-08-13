From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 13 Aug 2015 11:25:10 -0700
Subject: [PATCH V3 1/5] clk: remove duplicated code with
 __clk_set_parent_after
In-Reply-To: <1438089585-30103-2-git-send-email-aisheng.dong@freescale.com>
References: <1438089585-30103-1-git-send-email-aisheng.dong@freescale.com>
 <1438089585-30103-2-git-send-email-aisheng.dong@freescale.com>
Message-ID: <20150813182510.GQ26614@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/28, Dong Aisheng wrote:
> __clk_set_parent_after() actually used the second argument then we
> could put this duplicate logic in there and call it with a different
> order of arguments in the success vs. error paths in this function.
> 
> Cc: Mike Turquette <mturquette@linaro.org>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Suggested-by: Stephen Boyd <sboyd@codeaurora.org>
> Signed-off-by: Dong Aisheng <aisheng.dong@freescale.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
