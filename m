From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  5 Jun 2013 17:26:22 +0900
Subject: [PATCH 091/130] ARM: shmobile: r8a7740: Remove CEU function GPIOs
In-Reply-To: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
References: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1370420821-28420-92-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Those GPIOs have been deprecated by the pinctrl API. They are unused and
unneeded, remove them.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/include/mach/r8a7740.h | 28 ---------------------------
 1 file changed, 28 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/r8a7740.h b/arch/arm/mach-shmobile/include/mach/r8a7740.h
index 0db82aa..08b7da0 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7740.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7740.h
@@ -143,34 +143,6 @@ enum {
 	GPIO_FN_RSPI_MOSI_A,	GPIO_FN_RSPI_MISO_A,
 	GPIO_FN_RSPI_CK_A,
 
-	/* VIO CKO */
-	GPIO_FN_VIO_CKO1,
-	GPIO_FN_VIO_CKO2,
-	GPIO_FN_VIO_CKO_1,
-	GPIO_FN_VIO_CKO,
-
-	/* VIO0 */
-	GPIO_FN_VIO0_D0,	GPIO_FN_VIO0_D1,	GPIO_FN_VIO0_D2,
-	GPIO_FN_VIO0_D3,	GPIO_FN_VIO0_D4,	GPIO_FN_VIO0_D5,
-	GPIO_FN_VIO0_D6,	GPIO_FN_VIO0_D7,	GPIO_FN_VIO0_D8,
-	GPIO_FN_VIO0_D9,	GPIO_FN_VIO0_D10,	GPIO_FN_VIO0_D11,
-	GPIO_FN_VIO0_D12,	GPIO_FN_VIO0_VD,	GPIO_FN_VIO0_HD,
-	GPIO_FN_VIO0_CLK,	GPIO_FN_VIO0_FIELD,
-
-	GPIO_FN_VIO0_D13_PORT26, /* MSEL5CR_27_0 */
-	GPIO_FN_VIO0_D14_PORT25,
-	GPIO_FN_VIO0_D15_PORT24,
-
-	GPIO_FN_VIO0_D13_PORT22, /* MSEL5CR_27_1 */
-	GPIO_FN_VIO0_D14_PORT95,
-	GPIO_FN_VIO0_D15_PORT96,
-
-	/* VIO1 */
-	GPIO_FN_VIO1_D0,	GPIO_FN_VIO1_D1,	GPIO_FN_VIO1_D2,
-	GPIO_FN_VIO1_D3,	GPIO_FN_VIO1_D4,	GPIO_FN_VIO1_D5,
-	GPIO_FN_VIO1_D6,	GPIO_FN_VIO1_D7,	GPIO_FN_VIO1_VD,
-	GPIO_FN_VIO1_HD,	GPIO_FN_VIO1_CLK,	GPIO_FN_VIO1_FIELD,
-
 	/* TPU0 */
 	GPIO_FN_TPU0TO0,	GPIO_FN_TPU0TO1,
 	GPIO_FN_TPU0TO3,
-- 
1.8.2.1
