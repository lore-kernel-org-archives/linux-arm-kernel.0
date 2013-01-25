From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 25 Jan 2013 11:23:38 +0900
Subject: [PATCH 02/80] sh: sh7269: Rename CRX0CRX1(CRX2) marks to match GPIO
 names
In-Reply-To: <1359080696-31489-1-git-send-email-horms+renesas@verge.net.au>
References: <1359080696-31489-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1359080696-31489-3-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Rename CRX0CRX1_MARK and CRX0CRX1CRX2_MARK to CRX0_CRX1_MARK and
CRX0_CRX1_CRX2_MARK respectively to match the GPIO_FN_CRX0_CRX1 and
GPIO_FN_CRX0_CRX1_CRX2 GPIO names.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/sh/kernel/cpu/sh2a/pinmux-sh7269.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh2a/pinmux-sh7269.c b/arch/sh/kernel/cpu/sh2a/pinmux-sh7269.c
index 039e458..1289fd9 100644
--- a/arch/sh/kernel/cpu/sh2a/pinmux-sh7269.c
+++ b/arch/sh/kernel/cpu/sh2a/pinmux-sh7269.c
@@ -739,8 +739,8 @@ enum {
 	CRX0_MARK, CTX0_MARK,
 	CRX1_MARK, CTX1_MARK,
 	CRX2_MARK, CTX2_MARK,
-	CRX0CRX1_MARK,
-	CRX0CRX1CRX2_MARK,
+	CRX0_CRX1_MARK,
+	CRX0_CRX1_CRX2_MARK,
 	CTX0CTX1CTX2_MARK,
 	CRX1_PJ22_MARK, CTX1_PJ23_MARK,
 	CRX2_PJ20_MARK, CTX2_PJ21_MARK,
@@ -829,7 +829,7 @@ static pinmux_enum_t pinmux_data[] = {
 	PINMUX_DATA(CKE_MARK, PC7MD_001),
 	PINMUX_DATA(RXD7_MARK, PC7MD_010),
 	PINMUX_DATA(CRX1_MARK, PC7MD_011),
-	PINMUX_DATA(CRX0CRX1_MARK, PC7MD_100),
+	PINMUX_DATA(CRX0_CRX1_MARK, PC7MD_100),
 	PINMUX_DATA(IRQ1_PC_MARK, PC7MD_101),
 
 	PINMUX_DATA(PC6_DATA, PC6MD_000),
@@ -1300,7 +1300,7 @@ static pinmux_enum_t pinmux_data[] = {
 	PINMUX_DATA(LCD_TCON5_MARK, PJ22MD_011),
 	PINMUX_DATA(IRQ2_PJ_MARK, PJ22MD_100),
 	PINMUX_DATA(CRX1_MARK, PJ22MD_101),
-	PINMUX_DATA(CRX0CRX1_MARK, PJ22MD_110),
+	PINMUX_DATA(CRX0_CRX1_MARK, PJ22MD_110),
 
 	PINMUX_DATA(PJ21_DATA, PJ21MD_000),
 	PINMUX_DATA(DV_DATA21_MARK, PJ21MD_001),
@@ -1666,8 +1666,8 @@ static struct pinmux_gpio pinmux_gpios[] = {
 	PINMUX_GPIO(GPIO_FN_CRX1, CRX1_MARK),
 	PINMUX_GPIO(GPIO_FN_CTX0, CTX0_MARK),
 	PINMUX_GPIO(GPIO_FN_CRX0, CRX0_MARK),
-	PINMUX_GPIO(GPIO_FN_CRX0_CRX1, CRX0CRX1_MARK),
-	PINMUX_GPIO(GPIO_FN_CRX0_CRX1_CRX2, CRX0CRX1CRX2_MARK),
+	PINMUX_GPIO(GPIO_FN_CRX0_CRX1, CRX0_CRX1_MARK),
+	PINMUX_GPIO(GPIO_FN_CRX0_CRX1_CRX2, CRX0_CRX1_CRX2_MARK),
 
 	/* DMAC */
 	PINMUX_GPIO(GPIO_FN_TEND0, TEND0_MARK),
-- 
1.7.10.4
