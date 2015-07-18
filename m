From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 17 Jul 2015 17:47:58 -0700
Subject: [PATCH v3 3/3] clk: mediatek: Add MT8173 MMPLL change rate support
In-Reply-To: <1436517574-17895-4-git-send-email-jamesjj.liao@mediatek.com>
References: <1436517574-17895-1-git-send-email-jamesjj.liao@mediatek.com>
 <1436517574-17895-4-git-send-email-jamesjj.liao@mediatek.com>
Message-ID: <20150718004758.GX30412@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/10, James Liao wrote:
> MT8173 MMPLL frequency settings are different from common PLLs.
> It needs different post divider settings for some ranges of frequency.
> This patch add support for MT8173 MMPLL frequency setting by adding
> div-rate table to lookup suitable post divider setting under a
> specified frequency.
> 
> Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
