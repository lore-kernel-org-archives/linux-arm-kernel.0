From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 17 Jul 2015 17:47:49 -0700
Subject: [PATCH v3 1/3] clk: mediatek: Fix PLL registers setting flow
In-Reply-To: <1436517574-17895-2-git-send-email-jamesjj.liao@mediatek.com>
References: <1436517574-17895-1-git-send-email-jamesjj.liao@mediatek.com>
 <1436517574-17895-2-git-send-email-jamesjj.liao@mediatek.com>
Message-ID: <20150718004749.GV30412@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/10, James Liao wrote:
> Write postdiv and pcw settings at the same time for PLLs if postdiv
> and pcw settings are on the same register.
> 
> This is need by PLLs such as MT8173 MMPLL and ARM*PLL.
> 
> Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
