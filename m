From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Thu, 21 May 2015 14:05:10 +0200
Subject: [PATCH trivial] pinctrl: Spelling s/reseved/reserved/
Message-ID: <1432209910-21307-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/nomadik/pinctrl-ab8505.c |  2 +-
 drivers/pinctrl/sh-pfc/pfc-r8a7791.c     | 38 ++++++++++++++++----------------
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/pinctrl/nomadik/pinctrl-ab8505.c b/drivers/pinctrl/nomadik/pinctrl-ab8505.c
index bf0ef4ac376f6227..42c6e1f7886b489e 100644
--- a/drivers/pinctrl/nomadik/pinctrl-ab8505.c
+++ b/drivers/pinctrl/nomadik/pinctrl-ab8505.c
@@ -286,7 +286,7 @@ alternate_functions ab8505_alternate_functions[AB8505_GPIO_MAX_NUMBER + 1] = {
 	ALTERNATE_FUNCTIONS(9, UNUSED, UNUSED, UNUSED, 0, 0, 0), /* no GPIO9, bit 0 reserved */
 	ALTERNATE_FUNCTIONS(10,      1,      0, UNUSED, 1, 0, 0), /* GPIO10, altA and altB controlled by bit 0 */
 	ALTERNATE_FUNCTIONS(11,      2,      1, UNUSED, 0, 0, 0), /* GPIO11, altA controlled by bit 2 */
-	ALTERNATE_FUNCTIONS(12, UNUSED, UNUSED, UNUSED, 0, 0, 0), /* no GPIO12, bit3 reseved */
+	ALTERNATE_FUNCTIONS(12, UNUSED, UNUSED, UNUSED, 0, 0, 0), /* no GPIO12, bit3 reserved */
 	ALTERNATE_FUNCTIONS(13,      4,      3,      4, 1, 0, 2), /* GPIO13, altA altB and altC controlled by bit 3 and 4 */
 	ALTERNATE_FUNCTIONS(14,      5, UNUSED, UNUSED, 0, 0, 0), /* GPIO14, altA controlled by bit 5 */
 	ALTERNATE_FUNCTIONS(15, UNUSED, UNUSED, UNUSED, 0, 0, 0), /* no GPIO15, bit 6 reserved */
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c b/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
index cbf8ec3ae8ab1af7..355a324e4c563e96 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
@@ -6000,7 +6000,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 	{ PINMUX_CFG_REG_VAR("MOD_SEL", 0xE6060090, 32,
 			     1, 2, 2, 2, 3, 2, 1, 1, 1, 1,
 			     3, 2, 2, 2, 1, 2, 2, 2) {
-		/* RESEVED [1] */
+		/* RESERVED [1] */
 		0, 0,
 		/* SEL_SCIF1 [2] */
 		FN_SEL_SCIF1_0, FN_SEL_SCIF1_1, FN_SEL_SCIF1_2, FN_SEL_SCIF1_3,
@@ -6027,11 +6027,11 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		FN_SEL_HSCIF1_0, FN_SEL_HSCIF1_1, FN_SEL_HSCIF1_2,
 		FN_SEL_HSCIF1_3, FN_SEL_HSCIF1_4,
 		0, 0, 0,
-		/* RESEVED [2] */
+		/* RESERVED [2] */
 		0, 0, 0, 0,
 		/* SEL_VI1 [2] */
 		FN_SEL_VI1_0, FN_SEL_VI1_1, FN_SEL_VI1_2, 0,
-		/* RESEVED [2] */
+		/* RESERVED [2] */
 		0, 0, 0, 0,
 		/* SEL_TMU [1] */
 		FN_SEL_TMU1_0, FN_SEL_TMU1_1,
@@ -6049,7 +6049,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		FN_SEL_SCIF0_0, FN_SEL_SCIF0_1, FN_SEL_SCIF0_2,
 		FN_SEL_SCIF0_3, FN_SEL_SCIF0_4,
 		0, 0, 0,
-		/* RESEVED [1] */
+		/* RESERVED [1] */
 		0, 0,
 		/* SEL_SCIF [1] */
 		FN_SEL_SCIF_0, FN_SEL_SCIF_1,
@@ -6059,13 +6059,13 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0,
 		/* SEL_CAN1 [2] */
 		FN_SEL_CAN1_0, FN_SEL_CAN1_1, FN_SEL_CAN1_2, FN_SEL_CAN1_3,
-		/* RESEVED [1] */
+		/* RESERVED [1] */
 		0, 0,
 		/* SEL_SCIFA2 [1] */
 		FN_SEL_SCIFA2_0, FN_SEL_SCIFA2_1,
 		/* SEL_SCIF4 [2] */
 		FN_SEL_SCIF4_0, FN_SEL_SCIF4_1, FN_SEL_SCIF4_2, 0,
-		/* RESEVED [2] */
+		/* RESERVED [2] */
 		0, 0, 0, 0,
 		/* SEL_ADG [1] */
 		FN_SEL_ADG_0, FN_SEL_ADG_1,
@@ -6075,7 +6075,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0,
 		/* SEL_SCIFA5 [2] */
 		FN_SEL_SCIFA5_0, FN_SEL_SCIFA5_1, FN_SEL_SCIFA5_2, 0,
-		/* RESEVED [1] */
+		/* RESERVED [1] */
 		0, 0,
 		/* SEL_GPS [2] */
 		FN_SEL_GPS_0, FN_SEL_GPS_1, FN_SEL_GPS_2, FN_SEL_GPS_3,
@@ -6085,7 +6085,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		FN_SEL_SCIFA3_0, FN_SEL_SCIFA3_1, FN_SEL_SCIFA3_2, 0,
 		/* SEL_SIM [1] */
 		FN_SEL_SIM_0, FN_SEL_SIM_1,
-		/* RESEVED [1] */
+		/* RESERVED [1] */
 		0, 0,
 		/* SEL_SSI8 [1] */
 		FN_SEL_SSI8_0, FN_SEL_SSI8_1, }
@@ -6115,7 +6115,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		FN_SEL_MMC_0, FN_SEL_MMC_1,
 		/* SEL_SCIF5 [1] */
 		FN_SEL_SCIF5_0, FN_SEL_SCIF5_1,
-		/* RESEVED [2] */
+		/* RESERVED [2] */
 		0, 0, 0, 0,
 		/* SEL_IIC2 [2] */
 		FN_SEL_IIC2_0, FN_SEL_IIC2_1, FN_SEL_IIC2_2, FN_SEL_IIC2_3,
@@ -6125,11 +6125,11 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0,
 		/* SEL_IIC0 [2] */
 		FN_SEL_IIC0_0, FN_SEL_IIC0_1, FN_SEL_IIC0_2, 0,
-		/* RESEVED [2] */
+		/* RESERVED [2] */
 		0, 0, 0, 0,
-		/* RESEVED [2] */
+		/* RESERVED [2] */
 		0, 0, 0, 0,
-		/* RESEVED [1] */
+		/* RESERVED [1] */
 		0, 0, }
 	},
 	{ PINMUX_CFG_REG_VAR("MOD_SEL4", 0xE606009C, 32,
@@ -6143,7 +6143,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		FN_SEL_HSCIF0_0, FN_SEL_HSCIF0_1, FN_SEL_HSCIF0_2, 0,
 		/* SEL_DIS [2] */
 		FN_SEL_DIS_0, FN_SEL_DIS_1, FN_SEL_DIS_2, 0,
-		/* RESEVED [1] */
+		/* RESERVED [1] */
 		0, 0,
 		/* SEL_RAD [1] */
 		FN_SEL_RAD_0, FN_SEL_RAD_1,
@@ -6155,15 +6155,15 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		FN_SEL_SCIF2_0, FN_SEL_SCIF2_1, FN_SEL_SCIF2_2,
 		FN_SEL_SCIF2_3, FN_SEL_SCIF2_4,
 		0, 0, 0,
-		/* RESEVED [2] */
+		/* RESERVED [2] */
 		0, 0, 0, 0,
-		/* RESEVED [2] */
+		/* RESERVED [2] */
 		0, 0, 0, 0,
 		/* SEL_SOF2 [3] */
 		FN_SEL_SOF2_0, FN_SEL_SOF2_1, FN_SEL_SOF2_2,
 		FN_SEL_SOF2_3, FN_SEL_SOF2_4,
 		0, 0, 0,
-		/* RESEVED [1] */
+		/* RESERVED [1] */
 		0, 0,
 		/* SEL_SSI1 [1] */
 		FN_SEL_SSI1_0, FN_SEL_SSI1_1,
@@ -6171,11 +6171,11 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		FN_SEL_SSI0_0, FN_SEL_SSI0_1,
 		/* SEL_SSP [2] */
 		FN_SEL_SSP_0, FN_SEL_SSP_1, FN_SEL_SSP_2, 0,
-		/* RESEVED [2] */
+		/* RESERVED [2] */
 		0, 0, 0, 0,
-		/* RESEVED [2] */
+		/* RESERVED [2] */
 		0, 0, 0, 0,
-		/* RESEVED [2] */
+		/* RESERVED [2] */
 		0, 0, 0, 0, }
 	},
 	{ },
-- 
1.9.1
