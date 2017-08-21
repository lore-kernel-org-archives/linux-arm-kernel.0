From: zhangqing@rock-chips.com (Elaine Zhang)
Date: Mon, 21 Aug 2017 10:30:27 +0800
Subject: [PATCH v1 2/3] clk: rockchip: rv1108: add ACLK_GMAC and PCLK_GMAC clk
 id
In-Reply-To: <1503282628-23542-1-git-send-email-zhangqing@rock-chips.com>
References: <1503282628-23542-1-git-send-email-zhangqing@rock-chips.com>
Message-ID: <1503282628-23542-3-git-send-email-zhangqing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 drivers/clk/rockchip/clk-rv1108.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/rockchip/clk-rv1108.c b/drivers/clk/rockchip/clk-rv1108.c
index d1065dd9f442..0e441ec21e90 100644
--- a/drivers/clk/rockchip/clk-rv1108.c
+++ b/drivers/clk/rockchip/clk-rv1108.c
@@ -763,6 +763,8 @@ enum rv1108_plls {
 	GATE(SCLK_MACPHY_RX, "sclk_macphy_rx", "sclk_macphy", 0, RV1108_CLKGATE_CON(4), 8, GFLAGS),
 	GATE(SCLK_MAC_REF, "sclk_mac_ref", "sclk_macphy", 0, RV1108_CLKGATE_CON(4), 6, GFLAGS),
 	GATE(SCLK_MAC_REFOUT, "sclk_mac_refout", "sclk_macphy", 0, RV1108_CLKGATE_CON(4), 7, GFLAGS),
+	GATE(ACLK_GMAC, "aclk_gmac", "aclk_periph", 0, RV1108_CLKGATE_CON(15), 4, GFLAGS),
+	GATE(PCLK_GMAC, "pclk_gmac", "pclk_periph", 0, RV1108_CLKGATE_CON(15), 5, GFLAGS),
 
 	MMC(SCLK_SDMMC_DRV,    "sdmmc_drv",    "sclk_sdmmc", RV1108_SDMMC_CON0, 1),
 	MMC(SCLK_SDMMC_SAMPLE, "sdmmc_sample", "sclk_sdmmc", RV1108_SDMMC_CON1, 1),
-- 
1.9.1
