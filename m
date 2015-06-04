From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 4 Jun 2015 14:07:22 -0700
Subject: [PATCH 1/5] clk: mediatek: Fix apmixedsys clock registration
In-Reply-To: <1432192376-6712-2-git-send-email-jamesjj.liao@mediatek.com>
References: <1432192376-6712-1-git-send-email-jamesjj.liao@mediatek.com>
 <1432192376-6712-2-git-send-email-jamesjj.liao@mediatek.com>
Message-ID: <20150604210722.GN676@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/21, James Liao wrote:
> The size of clk_data should be the same as CLK_APMIXED_NR_CLK
> instead of ARRAY_SIZE(plls). CLK_APMIXED_* is numbered from 1, so
> CLK_APMIXED_NR_CLK will be greater than ARRAY_SIZE(plls).
> 
> Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
