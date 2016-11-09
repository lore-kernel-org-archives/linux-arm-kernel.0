From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 8 Nov 2016 16:01:20 -0800
Subject: [PATCH v15 2/4] reset: mediatek: Add MT2701 reset driver
In-Reply-To: <1478245388-1412-3-git-send-email-erin.lo@mediatek.com>
References: <1478245388-1412-1-git-send-email-erin.lo@mediatek.com>
 <1478245388-1412-3-git-send-email-erin.lo@mediatek.com>
Message-ID: <20161109000120.GQ16026@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/04, Erin Lo wrote:
> From: Shunli Wang <shunli.wang@mediatek.com>
> 
> In infrasys and perifsys, there are many reset
> control bits for kinds of modules. These bits are
> used as actual reset controllers to be registered
> into kernel's generic reset controller framework.
> 
> Signed-off-by: Shunli Wang <shunli.wang@mediatek.com>
> Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
> Signed-off-by: Erin Lo <erin.lo@mediatek.com>
> Tested-by: John Crispin <blogic@openwrt.org>
> Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
