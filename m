From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon,  8 Apr 2013 16:46:20 +0200
Subject: [PATCH 2/5] ARM i.MX53: Remove unused tve_gate clkdev entry
In-Reply-To: <1365432383-7787-1-git-send-email-p.zabel@pengutronix.de>
References: <1365432383-7787-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1365432383-7787-3-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 arch/arm/mach-imx/clk-imx51-imx53.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-imx/clk-imx51-imx53.c b/arch/arm/mach-imx/clk-imx51-imx53.c
index 9daef9d..890012e 100644
--- a/arch/arm/mach-imx/clk-imx51-imx53.c
+++ b/arch/arm/mach-imx/clk-imx51-imx53.c
@@ -319,7 +319,6 @@ static void __init mx5_clocks_common_init(unsigned long rate_ckil,
 	clk_register_clkdev(clk[dummy], NULL, "imx2-wdt.0");
 	clk_register_clkdev(clk[dummy], NULL, "imx2-wdt.1");
 	clk_register_clkdev(clk[dummy], NULL, "imx-keypad");
-	clk_register_clkdev(clk[tve_gate], NULL, "imx-tve.0");
 	clk_register_clkdev(clk[ipu_di1_gate], "di1", "imx-tve.0");
 	clk_register_clkdev(clk[gpc_dvfs], "gpc_dvfs", NULL);
 	clk_register_clkdev(clk[epit1_ipg_gate], "ipg", "imx-epit.0");
-- 
1.8.2.rc2
