From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 2 May 2016 17:37:12 -0700
Subject: [PATCH v2 01/13] clkdev: Remove clk_register_clkdevs()
In-Reply-To: <1461277324-27185-2-git-send-email-sboyd@codeaurora.org>
References: <1461277324-27185-1-git-send-email-sboyd@codeaurora.org>
 <1461277324-27185-2-git-send-email-sboyd@codeaurora.org>
Message-ID: <20160503003712.GG3492@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/21, Stephen Boyd wrote:
> Now that we've converted the only caller over to another clkdev
> API, remove this one.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
