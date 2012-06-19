From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 19 Jun 2012 17:27:32 -0300
Subject: [PATCH] clk: mxs: Fix the GPMI clock name
Message-ID: <1340137652-2227-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

The correct name for the GPMI clock is 'gpmi-nand'.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/clk/mxs/clk-imx23.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/clk/mxs/clk-imx23.c b/drivers/clk/mxs/clk-imx23.c
index f7be225..40ad638 100644
--- a/drivers/clk/mxs/clk-imx23.c
+++ b/drivers/clk/mxs/clk-imx23.c
@@ -106,7 +106,7 @@ static struct clk_lookup lcdif_lookups[] __initdata = {
 
 static struct clk_lookup gpmi_lookups[] __initdata = {
 	{ .dev_id = "imx23-gpmi-nand", },
-	{ .dev_id = "8000c000.gpmi", },
+	{ .dev_id = "8000c000.gpmi-nand", },
 };
 
 static const char *sel_pll[]  __initconst = { "pll", "ref_xtal", };
-- 
1.7.1
