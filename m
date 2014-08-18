From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 18 Aug 2014 15:06:20 +0800
Subject: [PATCH] ARM: imx: correct gpu2d_axi and gpu3d_axi clock setting
In-Reply-To: <1407835563-28220-1-git-send-email-b20788@freescale.com>
References: <1407835563-28220-1-git-send-email-b20788@freescale.com>
Message-ID: <20140818070618.GG2114@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 12, 2014 at 05:26:03PM +0800, Anson Huang wrote:
> On i.MX6Q, gpu2d_axi and gpu3d_axi are either from AXI or
> AHB clock, but on i.MX6DL, gpu2d_axi and gpu3d_axi are
> from mmdc_ch0_axi_podf, and they can NOT be gated by mmdc_ch0_axi
> 's clock gate, the mux option register field(CCM_CBCMR)
> is marked as "Reserved" now on i.MX6DL RM, so correct these
> two clks setting.
> 
> Signed-off-by: Anson Huang <b20788@freescale.com>

Applied, thanks.
