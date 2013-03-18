From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 20:07:08 +0900
Subject: [PATCH 132/142] ARM: shmobile: sh73a0: Remove IrDA function GPIOs
In-Reply-To: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
References: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363604838-29359-133-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Those GPIOs have been deprecated by the pinctrl API. They are unused and
unneeded, remove them.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/include/mach/sh73a0.h |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/sh73a0.h b/arch/arm/mach-shmobile/include/mach/sh73a0.h
index d488e2b..fbc1584 100644
--- a/arch/arm/mach-shmobile/include/mach/sh73a0.h
+++ b/arch/arm/mach-shmobile/include/mach/sh73a0.h
@@ -124,13 +124,13 @@ enum {
 	GPIO_FN_XWUP,
 	GPIO_FN_VACK,
 	GPIO_FN_XTAL1L,
-	GPIO_FN_PORT49_IRDA_OUT, GPIO_FN_PORT49_IROUT,
+	GPIO_FN_PORT49_IROUT,
 	GPIO_FN_BBIF2_TSYNC2, GPIO_FN_TPU2TO2,
 
 	GPIO_FN_BBIF2_TSCK2, GPIO_FN_TPU2TO3,
 	GPIO_FN_BBIF2_TXD2,
-	GPIO_FN_PORT53_IRDA_IN, GPIO_FN_TPU3TO3,
-	GPIO_FN_PORT54_IRDA_FIRSEL, GPIO_FN_TPU3TO2,
+	GPIO_FN_TPU3TO3,
+	GPIO_FN_TPU3TO2,
 	GPIO_FN_TPU0TO0,
 	GPIO_FN_A0, GPIO_FN_BS_,
 	GPIO_FN_A12, GPIO_FN_TPU4TO2,
@@ -255,10 +255,10 @@ enum {
 	GPIO_FN_MSIOF1_MCK1,
 	GPIO_FN_MSIOF1_SS1, GPIO_FN_VIO2_FIELD2,
 	GPIO_FN_MSIOF1_SS2, GPIO_FN_VIO2_HD2,
-	GPIO_FN_PORT241_IRDA_OUT, GPIO_FN_PORT241_IROUT, GPIO_FN_MFG4_OUT1, \
+	GPIO_FN_PORT241_IROUT, GPIO_FN_MFG4_OUT1, \
 	GPIO_FN_TPU4TO0,
-	GPIO_FN_PORT242_IRDA_IN, GPIO_FN_MFG4_IN2,
-	GPIO_FN_PORT243_IRDA_FIRSEL, GPIO_FN_PORT243_VIO_CKO2,
+	GPIO_FN_MFG4_IN2,
+	GPIO_FN_PORT243_VIO_CKO2,
 	GPIO_FN_MFG2_IN1,
 	GPIO_FN_MSIOF2R_RXD,
 	GPIO_FN_MFG2_IN2,
-- 
1.7.10.4
