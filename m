From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 19 Aug 2016 12:46:26 -0700
Subject: [PATCH v11 2/9] clk: mediatek: Refine the makefile to support
 multiple clock drivers
In-Reply-To: <1471584896-9986-3-git-send-email-erin.lo@mediatek.com>
References: <1471584896-9986-1-git-send-email-erin.lo@mediatek.com>
 <1471584896-9986-3-git-send-email-erin.lo@mediatek.com>
Message-ID: <20160819194626.GD6502@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/19, Erin Lo wrote:
> From: James Liao <jamesjj.liao@mediatek.com>
> 
> Add a Kconfig to define clock configuration for each SoC, and
> modify the Makefile to build drivers that only selected in config.
> 
> Signed-off-by: Shunli Wang <shunli.wang@mediatek.com>
> Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
> Signed-off-by: Erin Lo <erin.lo@mediatek.com>
> Tested-by: John Crispin <blogic@openwrt.org>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
