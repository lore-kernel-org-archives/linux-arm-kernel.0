From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 20:06:46 +0900
Subject: [PATCH 110/142] sh-pfc: sh73a0: Remove KEYSC function GPIOS
In-Reply-To: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
References: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363604838-29359-111-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

All sh73a0 platforms now use the pinctrl API to control the KEYSC pins,
the corresponding function GPIOS are unused. Remove them.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/sh-pfc/pfc-sh73a0.c |   30 ------------------------------
 1 file changed, 30 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
index 1249a3f..33e2b3f 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
@@ -2996,48 +2996,32 @@ static const struct pinmux_func pinmux_func_gpios[] = {
 	GPIO_FN(A0), \
 	GPIO_FN(BS_),
 	GPIO_FN(A12), \
-	GPIO_FN(PORT58_KEYOUT7), \
 	GPIO_FN(TPU4TO2),
 	GPIO_FN(A13), \
-	GPIO_FN(PORT59_KEYOUT6), \
 	GPIO_FN(TPU0TO1),
 	GPIO_FN(A14), \
-	GPIO_FN(KEYOUT5),
 	GPIO_FN(A15), \
-	GPIO_FN(KEYOUT4),
 	GPIO_FN(A16), \
-	GPIO_FN(KEYOUT3), \
 	GPIO_FN(MSIOF0_SS1),
 	GPIO_FN(A17), \
-	GPIO_FN(KEYOUT2), \
 	GPIO_FN(MSIOF0_TSYNC),
 	GPIO_FN(A18), \
-	GPIO_FN(KEYOUT1), \
 	GPIO_FN(MSIOF0_TSCK),
 	GPIO_FN(A19), \
-	GPIO_FN(KEYOUT0), \
 	GPIO_FN(MSIOF0_TXD),
 	GPIO_FN(A20), \
-	GPIO_FN(KEYIN0), \
 	GPIO_FN(MSIOF0_RSCK),
 	GPIO_FN(A21), \
-	GPIO_FN(KEYIN1), \
 	GPIO_FN(MSIOF0_RSYNC),
 	GPIO_FN(A22), \
-	GPIO_FN(KEYIN2), \
 	GPIO_FN(MSIOF0_MCK0),
 	GPIO_FN(A23), \
-	GPIO_FN(KEYIN3), \
 	GPIO_FN(MSIOF0_MCK1),
 	GPIO_FN(A24), \
-	GPIO_FN(KEYIN4), \
 	GPIO_FN(MSIOF0_RXD),
 	GPIO_FN(A25), \
-	GPIO_FN(KEYIN5), \
 	GPIO_FN(MSIOF0_SS2),
 	GPIO_FN(A26), \
-	GPIO_FN(KEYIN6),
-	GPIO_FN(KEYIN7),
 	GPIO_FN(D0_NAF0),
 	GPIO_FN(D1_NAF1),
 	GPIO_FN(D2_NAF2),
@@ -3105,13 +3089,9 @@ static const struct pinmux_func pinmux_func_gpios[] = {
 	GPIO_FN(VIO_D0), \
 	GPIO_FN(PORT130_MSIOF2_RXD), \
 	GPIO_FN(VIO_D1), \
-	GPIO_FN(PORT131_KEYOUT6), \
 	GPIO_FN(PORT131_MSIOF2_SS1), \
-	GPIO_FN(PORT131_KEYOUT11), \
 	GPIO_FN(VIO_D2), \
-	GPIO_FN(PORT132_KEYOUT7), \
 	GPIO_FN(PORT132_MSIOF2_SS2), \
-	GPIO_FN(PORT132_KEYOUT10), \
 	GPIO_FN(VIO_D3), \
 	GPIO_FN(MSIOF2_TSYNC), \
 	GPIO_FN(VIO_D4), \
@@ -3119,14 +3099,10 @@ static const struct pinmux_func pinmux_func_gpios[] = {
 	GPIO_FN(VIO_D5), \
 	GPIO_FN(MSIOF2_TSCK), \
 	GPIO_FN(VIO_D6), \
-	GPIO_FN(PORT136_KEYOUT8), \
 	GPIO_FN(VIO_D7), \
-	GPIO_FN(PORT137_KEYOUT9), \
 	GPIO_FN(VIO_D8), \
-	GPIO_FN(PORT138_KEYOUT8), \
 	GPIO_FN(VIO2_D0), \
 	GPIO_FN(VIO_D9), \
-	GPIO_FN(PORT139_KEYOUT9), \
 	GPIO_FN(VIO2_D1), \
 	GPIO_FN(VIO_D10), \
 	GPIO_FN(TPU0TO2), \
@@ -3135,14 +3111,10 @@ static const struct pinmux_func pinmux_func_gpios[] = {
 	GPIO_FN(TPU0TO3), \
 	GPIO_FN(VIO2_D3), \
 	GPIO_FN(VIO_D12), \
-	GPIO_FN(PORT142_KEYOUT10), \
 	GPIO_FN(VIO2_D4), \
 	GPIO_FN(VIO_D13), \
-	GPIO_FN(PORT143_KEYOUT11), \
-	GPIO_FN(PORT143_KEYOUT6), \
 	GPIO_FN(VIO2_D5), \
 	GPIO_FN(VIO_D14), \
-	GPIO_FN(PORT144_KEYOUT7), \
 	GPIO_FN(VIO2_D6), \
 	GPIO_FN(VIO_D15), \
 	GPIO_FN(TPU1TO3), \
@@ -3155,7 +3127,6 @@ static const struct pinmux_func pinmux_func_gpios[] = {
 	GPIO_FN(A27), \
 	GPIO_FN(PORT149_RDWR), \
 	GPIO_FN(MFG0_IN1), \
-	GPIO_FN(PORT149_KEYOUT9),
 	GPIO_FN(MFG0_IN2),
 	GPIO_FN(TS_SPSYNC3), \
 	GPIO_FN(MSIOF2_RSCK),
@@ -3383,7 +3354,6 @@ static const struct pinmux_func pinmux_func_gpios[] = {
 	GPIO_FN(IRQ9_MEM_INT),
 	GPIO_FN(IRQ9_MCP_INT),
 	GPIO_FN(A11),
-	GPIO_FN(KEYOUT8),
 	GPIO_FN(TPU4TO3),
 	GPIO_FN(RESETA_N_PU_ON),
 	GPIO_FN(RESETA_N_PU_OFF),
-- 
1.7.10.4
