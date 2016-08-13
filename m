From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 12 Aug 2016 17:57:05 -0700
Subject: [PATCH] clk: imx7d: do not set the parent of
 IMX7D_ENET_AXI_ROOT_SRC
In-Reply-To: <1468590782-8436-1-git-send-email-fabio.estevam@nxp.com>
References: <1468590782-8436-1-git-send-email-fabio.estevam@nxp.com>
Message-ID: <20160813005705.GE361@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/15, Fabio Estevam wrote:
> Booting the kernel on a imx7s-warp leads to several warnings like these:
> 
> [    0.000000] ------------[ cut here ]------------

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
