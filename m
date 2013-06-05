From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  5 Jun 2013 17:26:29 +0900
Subject: [PATCH 098/130] sh-pfc: r8a7778: Fix outdated GPIO_FN comments
In-Reply-To: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
References: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1370420821-28420-99-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Function GPIOs have been removed, remove comments that refer to them.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7778.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7778.c b/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
index b1925cc..72f7a3c 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
@@ -376,19 +376,19 @@ enum {
 	AVS1_MARK,
 	AVS2_MARK,
 
-	VI0_R0_C_MARK,  /* see GPIO_FN_VI0_R0_A */
-	VI0_R1_C_MARK,  /* see GPIO_FN_VI0_R1_A */
-	VI0_R2_C_MARK,  /* see GPIO_FN_VI0_R2_A */
-	/* VI0_R3_C_MARK,  see GPIO_FN_VI0_R3_A */
-	VI0_R4_C_MARK,  /* see GPIO_FN_VI0_R4_A */
-	VI0_R5_C_MARK,  /* see GPIO_FN_VI0_R5_A */
-
-	VI0_R0_D_MARK,  /* see GPIO_FN_VI0_R0_B */
-	VI0_R1_D_MARK,  /* see GPIO_FN_VI0_R1_B */
-	VI0_R2_D_MARK,  /* see GPIO_FN_VI0_R2_B */
-	VI0_R3_D_MARK,  /* see GPIO_FN_VI0_R3_B */
-	VI0_R4_D_MARK,  /* see GPIO_FN_VI0_R4_B */
-	VI0_R5_D_MARK,  /* see GPIO_FN_VI0_R5_B */
+	VI0_R0_C_MARK,		/* see sel_vi0 */
+	VI0_R1_C_MARK,		/* see sel_vi0 */
+	VI0_R2_C_MARK,		/* see sel_vi0 */
+	/* VI0_R3_C_MARK, */
+	VI0_R4_C_MARK,		/* see sel_vi0 */
+	VI0_R5_C_MARK,		/* see sel_vi0 */
+
+	VI0_R0_D_MARK,		/* see sel_vi0 */
+	VI0_R1_D_MARK,		/* see sel_vi0 */
+	VI0_R2_D_MARK,		/* see sel_vi0 */
+	VI0_R3_D_MARK,		/* see sel_vi0 */
+	VI0_R4_D_MARK,		/* see sel_vi0 */
+	VI0_R5_D_MARK,		/* see sel_vi0 */
 
 	/* IPSR0 */
 	PRESETOUT_MARK,	PWM1_MARK,	AUDATA0_MARK,
-- 
1.8.2.1
