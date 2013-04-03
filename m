From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  3 Apr 2013 11:05:01 +0900
Subject: [PATCH 23/28] sh-pfc: r8a73a4: Remove IRQC function GPIOS
In-Reply-To: <1364954706-14727-1-git-send-email-horms+renesas@verge.net.au>
References: <1364954706-14727-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1364954706-14727-24-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

The r8a73a4 board support will use the pinctrl API to control the
external IRQ pins so remove the unused function GPIOS.

Signed-off-by: Magnus Damm <damm@opensource.se>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/pinctrl/sh-pfc/pfc-r8a73a4.c |   58 ----------------------------------
 1 file changed, 58 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c b/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c
index 470b18f..66fc747 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c
@@ -2049,99 +2049,83 @@ static const struct pinmux_func pinmux_func_gpios[] = {
 	GPIO_FN(LCDD0),
 	GPIO_FN(PDM2_CLK_0),
 	GPIO_FN(DU0_DR0),
-	GPIO_FN(IRQ0),
 
 	/* Port1 */
 	GPIO_FN(LCDD1),
 	GPIO_FN(PDM2_DATA_1),
 	GPIO_FN(DU0_DR19),
-	GPIO_FN(IRQ1),
 
 	/* Port2 */
 	GPIO_FN(LCDD2),
 	GPIO_FN(PDM3_CLK_2),
 	GPIO_FN(DU0_DR2),
-	GPIO_FN(IRQ2),
 
 	/* Port3 */
 	GPIO_FN(LCDD3),
 	GPIO_FN(PDM3_DATA_3),
 	GPIO_FN(DU0_DR3),
-	GPIO_FN(IRQ3),
 
 	/* Port4 */
 	GPIO_FN(LCDD4),
 	GPIO_FN(PDM4_CLK_4),
 	GPIO_FN(DU0_DR4),
-	GPIO_FN(IRQ4),
 
 	/* Port5 */
 	GPIO_FN(LCDD5),
 	GPIO_FN(PDM4_DATA_5),
 	GPIO_FN(DU0_DR5),
-	GPIO_FN(IRQ5),
 
 	/* Port6 */
 	GPIO_FN(LCDD6),
 	GPIO_FN(PDM0_OUTCLK_6),
 	GPIO_FN(DU0_DR6),
-	GPIO_FN(IRQ6),
 
 	/* Port7 */
 	GPIO_FN(LCDD7),
 	GPIO_FN(PDM0_OUTDATA_7),
 	GPIO_FN(DU0_DR7),
-	GPIO_FN(IRQ7),
 
 	/* Port8 */
 	GPIO_FN(LCDD8),
 	GPIO_FN(PDM1_OUTCLK_8),
 	GPIO_FN(DU0_DG0),
-	GPIO_FN(IRQ8),
 
 	/* Port9 */
 	GPIO_FN(LCDD9),
 	GPIO_FN(PDM1_OUTDATA_9),
 	GPIO_FN(DU0_DG1),
-	GPIO_FN(IRQ9),
 
 	/* Port10 */
 	GPIO_FN(LCDD10),
 	GPIO_FN(FSICCK),
 	GPIO_FN(DU0_DG2),
-	GPIO_FN(IRQ10),
 
 	/* Port11 */
 	GPIO_FN(LCDD11),
 	GPIO_FN(FSICISLD),
 	GPIO_FN(DU0_DG3),
-	GPIO_FN(IRQ11),
 
 	/* Port12 */
 	GPIO_FN(LCDD12),
 	GPIO_FN(FSICOMC),
 	GPIO_FN(DU0_DG4),
-	GPIO_FN(IRQ12),
 
 	/* Port13 */
 	GPIO_FN(LCDD13),
 	GPIO_FN(FSICOLR),
 	GPIO_FN(FSICILR),
 	GPIO_FN(DU0_DG5),
-	GPIO_FN(IRQ13),
 
 	/* Port14 */
 	GPIO_FN(LCDD14),
 	GPIO_FN(FSICOBT),
 	GPIO_FN(FSICIBT),
 	GPIO_FN(DU0_DG6),
-	GPIO_FN(IRQ14),
 
 	/* Port15 */
 	GPIO_FN(LCDD15),
 	GPIO_FN(FSICOSLD),
 	GPIO_FN(DU0_DG7),
-	GPIO_FN(IRQ15),
 
 	/* Port16 */
 	GPIO_FN(LCDD16),
@@ -2254,7 +2238,6 @@ static const struct pinmux_func pinmux_func_gpios[] = {
 	GPIO_FN(HSI_RX_WAKE),
 	GPIO_FN(MSIOF3_SYNC),
 	GPIO_FN(GenIO4),
-	GPIO_FN(IRQ40),
 
 	/* Port67 */
 	GPIO_FN(HSI_RX_READY),
@@ -2304,8 +2287,6 @@ static const struct pinmux_func pinmux_func_gpios[] = {
 	GPIO_FN(TXP2),
 	GPIO_FN(COEX_0),
 	GPIO_FN(COEX_1),
-	GPIO_FN(IRQ19),
-	GPIO_FN(IRQ18),
 
 	/* Port96 - Port101 */
 	GPIO_FN(KEYIN0),
@@ -2317,11 +2298,9 @@ static const struct pinmux_func pinmux_func_gpios[] = {
 
 	/* Port102 */
 	GPIO_FN(KEYIN6),
-	GPIO_FN(IRQ41),
 
 	/* Port103 */
 	GPIO_FN(KEYIN7),
-	GPIO_FN(IRQ42),
 
 	/* Port104 - Port108 */
 	GPIO_FN(KEYOUT0),
@@ -2332,40 +2311,33 @@ static const struct pinmux_func pinmux_func_gpios[] = {
 
 	/* Port109 */
 	GPIO_FN(KEYOUT5),
-	GPIO_FN(IRQ43),
 
 	/* Port110 */
 	GPIO_FN(KEYOUT6),
-	GPIO_FN(IRQ44),
 
 	/* Port111 */
 	GPIO_FN(KEYOUT7),
 	GPIO_FN(RFANAEN),
-	GPIO_FN(IRQ45),
 
 	/* Port112 */
 	GPIO_FN(KEYIN8),
 	GPIO_FN(KEYOUT8),
 	GPIO_FN(SF_IRQ_04),
-	GPIO_FN(IRQ46),
 
 	/* Port113 */
 	GPIO_FN(KEYIN9),
 	GPIO_FN(KEYOUT9),
 	GPIO_FN(SF_IRQ_05),
-	GPIO_FN(IRQ47),
 
 	/* Port114 */
 	GPIO_FN(KEYIN10),
 	GPIO_FN(KEYOUT10),
 	GPIO_FN(SF_IRQ_06),
-	GPIO_FN(IRQ48),
 
 	/* Port115 */
 	GPIO_FN(KEYIN11),
 	GPIO_FN(KEYOUT11),
 	GPIO_FN(SF_IRQ_07),
-	GPIO_FN(IRQ49),
 
 	/* Port116 */
 	GPIO_FN(CSCIF0_TX),
@@ -2444,10 +2416,6 @@ static const struct pinmux_func pinmux_func_gpios[] = {
 	GPIO_FN(STP_ISD_1),
 
 	/* Port160 - Port178 */
-	GPIO_FN(IRQ20),
-	GPIO_FN(IRQ21),
-	GPIO_FN(IRQ22),
-	GPIO_FN(IRQ23),
 	GPIO_FN(MMCD0_0),
 	GPIO_FN(MMCD0_1),
 	GPIO_FN(MMCD0_2),
@@ -2459,10 +2427,6 @@ static const struct pinmux_func pinmux_func_gpios[] = {
 	GPIO_FN(MMCCMD0),
 	GPIO_FN(MMCCLK0),
 	GPIO_FN(MMCRST),
-	GPIO_FN(IRQ24),
-	GPIO_FN(IRQ25),
-	GPIO_FN(IRQ26),
-	GPIO_FN(IRQ27),
 
 	/* Port192 - Port200 FN1 */
 	GPIO_FN(A10),
@@ -2487,15 +2451,6 @@ static const struct pinmux_func pinmux_func_gpios[] = {
 	GPIO_FN(MMCCMD1),
 
 	/* Port192 - Port200 IRQ */
-	GPIO_FN(IRQ31),
-	GPIO_FN(IRQ32),
-	GPIO_FN(IRQ33),
-	GPIO_FN(IRQ34),
-	GPIO_FN(IRQ35),
-	GPIO_FN(IRQ36),
-	GPIO_FN(IRQ37),
-	GPIO_FN(IRQ38),
-	GPIO_FN(IRQ39),
 
 	/* Port201 */
 	GPIO_FN(A1),
@@ -2752,7 +2707,6 @@ static const struct pinmux_func pinmux_func_gpios[] = {
 	/* Port290 */
 	GPIO_FN(SDHID1_1),
 	GPIO_FN(STMDATA1_2),
-	GPIO_FN(IRQ51),
 
 	/* Port291 - Port294 FN1 */
 	GPIO_FN(SDHID1_2),
@@ -2774,7 +2728,6 @@ static const struct pinmux_func pinmux_func_gpios[] = {
 	/* Port296 */
 	GPIO_FN(SDHID2_1),
 	GPIO_FN(MSIOF6_SS2),
-	GPIO_FN(IRQ52),
 
 	/* Port297 - Port300 FN1 */
 	GPIO_FN(SDHID2_2),
@@ -2798,7 +2751,6 @@ static const struct pinmux_func pinmux_func_gpios[] = {
 
 	/* Port301 */
 	GPIO_FN(SDHICD0),
-	GPIO_FN(IRQ50),
 
 	/* Port302 - Port306 FN1 */
 	GPIO_FN(SDHID0_0),
@@ -2822,16 +2774,6 @@ static const struct pinmux_func pinmux_func_gpios[] = {
 	GPIO_FN(STMCLK_1),
 
 	/* Port320 - Port329 */
-	GPIO_FN(IRQ16),
-	GPIO_FN(IRQ17),
-	GPIO_FN(IRQ28),
-	GPIO_FN(IRQ29),
-	GPIO_FN(IRQ30),
-	GPIO_FN(IRQ53),
-	GPIO_FN(IRQ54),
-	GPIO_FN(IRQ55),
-	GPIO_FN(IRQ56),
-	GPIO_FN(IRQ57),
 };
 
 static const struct pinmux_cfg_reg pinmux_config_regs[] = {
-- 
1.7.10.4
