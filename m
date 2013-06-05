From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  5 Jun 2013 17:26:49 +0900
Subject: [PATCH 118/130] pinctrl: sh-pfc: fix a typo in pfc-r8a7790
In-Reply-To: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
References: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1370420821-28420-119-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Fix multiple occurrences of the "RESEVED" typo.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
index a2f83ae..9338422 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
@@ -3443,7 +3443,7 @@ static struct pinmux_cfg_reg pinmux_config_regs[] = {
 	{ PINMUX_CFG_REG_VAR("MOD_SEL2", 0xE6060094, 32,
 			     3, 1, 1, 1, 2, 1, 2, 1, 2,
 			     1, 1, 1, 3, 3, 2, 3, 2, 2) {
-		/* RESEVED [3] */
+		/* RESERVED [3] */
 		0, 0, 0, 0, 0, 0, 0, 0,
 		/* SEL_TMU1 [1] */
 		FN_SEL_TMU1_0, FN_SEL_TMU1_1,
@@ -3459,9 +3459,9 @@ static struct pinmux_cfg_reg pinmux_config_regs[] = {
 		FN_SEL_SCIFA2_0, FN_SEL_SCIFA2_1, FN_SEL_SCIFA2_2, 0,
 		/* SEL_CAN1 [1] */
 		FN_SEL_CAN1_0, FN_SEL_CAN1_1,
-		/* RESEVED [2] */
+		/* RESERVED [2] */
 		0, 0, 0, 0,
-		/* RESEVED [1] (actually TX2, RX2 vs. TX2_B, RX2_B of SCIF2) */
+		/* RESERVED [1] (actually TX2, RX2 vs. TX2_B, RX2_B of SCIF2) */
 		0, 0,
 		/* SEL_ADI [1] */
 		FN_SEL_ADI_0, FN_SEL_ADI_1,
@@ -3490,22 +3490,22 @@ static struct pinmux_cfg_reg pinmux_config_regs[] = {
 		FN_SEL_IICDVFS_0, FN_SEL_IICDVFS_1,
 		/* SEL_IIC0 [1] */
 		FN_SEL_IIC0_0, FN_SEL_IIC0_1,
-		/* RESEVED [2] */
+		/* RESERVED [2] */
 		0, 0, 0, 0,
-		/* RESEVED [4] */
+		/* RESERVED [4] */
 		0, 0, 0, 0, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
-		/* RESEVED [4] */
+		/* RESERVED [4] */
 		0, 0, 0, 0, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
-		/* RESEVED [2] */
+		/* RESERVED [2] */
 		0, 0, 0, 0,
 		/* SEL_IEB [2] */
 		FN_SEL_IEB_0, FN_SEL_IEB_1, FN_SEL_IEB_2, 0,
-		/* RESEVED [4] */
+		/* RESERVED [4] */
 		0, 0, 0, 0, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
-		/* RESEVED [2] */
+		/* RESERVED [2] */
 		0, 0, 0, 0,
 		/* SEL_IIC2 [3] */
 		FN_SEL_IIC2_0, FN_SEL_IIC2_1, FN_SEL_IIC2_2, FN_SEL_IIC2_3,
-- 
1.8.2.1
