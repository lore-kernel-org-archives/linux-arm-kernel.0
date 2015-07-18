From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 17 Jul 2015 17:47:53 -0700
Subject: [PATCH v3 2/3] clk: mediatek: Fix calculation of PLL rate settings
In-Reply-To: <1436517574-17895-3-git-send-email-jamesjj.liao@mediatek.com>
References: <1436517574-17895-1-git-send-email-jamesjj.liao@mediatek.com>
 <1436517574-17895-3-git-send-email-jamesjj.liao@mediatek.com>
Message-ID: <20150718004753.GW30412@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/10, James Liao wrote:
> Avoid u32 overflow when calculate post divider setting, and
> increase the max post divider setting from 3 (/8) to 4 (/16).
> 
> Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
