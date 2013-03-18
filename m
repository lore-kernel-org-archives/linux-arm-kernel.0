From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 20:06:47 +0900
Subject: [PATCH 111/142] sh-pfc: sh73a0: Remove BSC function GPIOS
In-Reply-To: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
References: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363604838-29359-112-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

All sh73a0 platforms now use the pinctrl API to control the BSC pins,
the corresponding function GPIOS are unused. Remove them.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/sh-pfc/pfc-sh73a0.c |   27 ---------------------------
 1 file changed, 27 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
index 33e2b3f..7b010b6 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
@@ -3022,37 +3022,11 @@ static const struct pinmux_func pinmux_func_gpios[] = {
 	GPIO_FN(A25), \
 	GPIO_FN(MSIOF0_SS2),
 	GPIO_FN(A26), \
-	GPIO_FN(D0_NAF0),
-	GPIO_FN(D1_NAF1),
-	GPIO_FN(D2_NAF2),
-	GPIO_FN(D3_NAF3),
-	GPIO_FN(D4_NAF4),
-	GPIO_FN(D5_NAF5),
-	GPIO_FN(D6_NAF6),
-	GPIO_FN(D7_NAF7),
-	GPIO_FN(D8_NAF8),
-	GPIO_FN(D9_NAF9),
-	GPIO_FN(D10_NAF10),
-	GPIO_FN(D11_NAF11),
-	GPIO_FN(D12_NAF12),
-	GPIO_FN(D13_NAF13),
-	GPIO_FN(D14_NAF14),
-	GPIO_FN(D15_NAF15),
-	GPIO_FN(CS4_),
-	GPIO_FN(CS5A_), \
-	GPIO_FN(PORT91_RDWR),
-	GPIO_FN(CS5B_), \
 	GPIO_FN(FCE1_),
-	GPIO_FN(CS6B_), \
 	GPIO_FN(DACK0),
 	GPIO_FN(FCE0_), \
-	GPIO_FN(CS6A_),
 	GPIO_FN(WAIT_), \
 	GPIO_FN(DREQ0),
-	GPIO_FN(RD__FSC),
-	GPIO_FN(WE0__FWE), \
-	GPIO_FN(RDWR_FWE),
-	GPIO_FN(WE1_),
 	GPIO_FN(FRB),
 	GPIO_FN(CKO),
 	GPIO_FN(NBRSTOUT_),
@@ -3125,7 +3099,6 @@ static const struct pinmux_func pinmux_func_gpios[] = {
 	GPIO_FN(VIO2_FIELD), \
 	GPIO_FN(VIO_CKO),
 	GPIO_FN(A27), \
-	GPIO_FN(PORT149_RDWR), \
 	GPIO_FN(MFG0_IN1), \
 	GPIO_FN(MFG0_IN2),
 	GPIO_FN(TS_SPSYNC3), \
-- 
1.7.10.4
