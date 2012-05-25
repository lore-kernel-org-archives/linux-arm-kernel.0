From: b32955@freescale.com (Huang Shijie)
Date: Fri, 25 May 2012 17:25:36 +0800
Subject: [PATCH 2/2] clk: mxs: rename the gpmi clock for imx28
In-Reply-To: <1337937936-2743-1-git-send-email-b32955@freescale.com>
References: <1337937936-2743-1-git-send-email-b32955@freescale.com>
Message-ID: <1337937936-2743-2-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

rename the clock name from `8000c000.gpmi` to `8000c000.gpmi-nand`.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 drivers/clk/mxs/clk-imx28.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/clk/mxs/clk-imx28.c b/drivers/clk/mxs/clk-imx28.c
index 2826a26..003b0f3 100644
--- a/drivers/clk/mxs/clk-imx28.c
+++ b/drivers/clk/mxs/clk-imx28.c
@@ -174,7 +174,7 @@ static struct clk_lookup lcdif_lookups[] __initdata = {
 
 static struct clk_lookup gpmi_lookups[] __initdata = {
 	{ .dev_id = "imx28-gpmi-nand", },
-	{ .dev_id = "8000c000.gpmi", },
+	{ .dev_id = "8000c000.gpmi-nand", },
 };
 
 static struct clk_lookup fec_lookups[] __initdata = {
-- 
1.7.0.4
