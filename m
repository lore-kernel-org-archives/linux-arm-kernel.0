From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 5 Sep 2014 08:43:23 +0800
Subject: [PATCH] ARM: clk-imx6sl: correct the pxp and epdc axi clock
 selections
In-Reply-To: <1409819592-31462-1-git-send-email-chen.fang@freescale.com>
References: <1409819592-31462-1-git-send-email-chen.fang@freescale.com>
Message-ID: <20140905004322.GE10809@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 04, 2014 at 04:33:12PM +0800, Fancy Fang wrote:
> The parent clocks of IMX6SL_CLK_PXP_AXI_SEL and IMX6SL_CLK_EPDC_AXI_SEL
> clocks are not the same. So split the epdc_pxp_sels into two different
> clock selections 'pxp_axi_sels' and 'epdc_axi_sels'.
> 
> Signed-off-by: Fancy Fang <chen.fang@freescale.com>
> Signed-off-by: Robby Cai <R63905@freescale.com>

Applied, thanks.
