From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 30 Aug 2017 22:32:22 -0700
Subject: [PATCH 2/2] clk: zte: constify clk_div_table
In-Reply-To: <1503898133-10862-3-git-send-email-arvind.yadav.cs@gmail.com>
References: <1503898133-10862-1-git-send-email-arvind.yadav.cs@gmail.com>
 <1503898133-10862-3-git-send-email-arvind.yadav.cs@gmail.com>
Message-ID: <20170831053222.GB21656@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/28, Arvind Yadav wrote:
> clk_div_table are not supposed to change at runtime. All functions
> working with clk_div_table provided by <linux/clk-provider.h> work
> with const clk_div_table. So mark the non-const structs as const.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
