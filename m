From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 30 Apr 2015 18:10:43 -0700
Subject: [PATCH RFC v1 5/5] clk: introduce clk_core_enable_lock and
 clk_core_disable_lock functions
In-Reply-To: <1429107999-24413-6-git-send-email-aisheng.dong@freescale.com>
References: <1429107999-24413-1-git-send-email-aisheng.dong@freescale.com>
 <1429107999-24413-6-git-send-email-aisheng.dong@freescale.com>
Message-ID: <20150501011043.GF32407@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/15, Dong Aisheng wrote:
> This can be usefully when clock core wants to enable/disable clocks.
> Then we don't have to convert the struct clk_core to struct clk to call
> clk_enable/clk_disable which is a bit un-align with exist using.
> 
> Cc: Mike Turquette <mturquette@linaro.org>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Signed-off-by: Dong Aisheng <aisheng.dong@freescale.com>
> ---

Yeah let's add this patch either before patch 4 or squash it into
patch 4. Also, avoid adding more function prototypes please.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
