From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 20:07:06 +0900
Subject: [PATCH 130/142] ARM: shmobile: sh73a0: Remove BSC function GPIOs
In-Reply-To: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
References: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363604838-29359-131-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Those GPIOs have been deprecated by the pinctrl API. They are unused and
unneeded, remove them.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/include/mach/sh73a0.h |   29 ++++----------------------
 1 file changed, 4 insertions(+), 25 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/sh73a0.h b/arch/arm/mach-shmobile/include/mach/sh73a0.h
index f1b85ff..218e6b7 100644
--- a/arch/arm/mach-shmobile/include/mach/sh73a0.h
+++ b/arch/arm/mach-shmobile/include/mach/sh73a0.h
@@ -149,31 +149,10 @@ enum {
 	GPIO_FN_A24, GPIO_FN_MSIOF0_RXD,
 	GPIO_FN_A25, GPIO_FN_MSIOF0_SS2,
 	GPIO_FN_A26,
-	GPIO_FN_D0_NAF0,
-	GPIO_FN_D1_NAF1,
-	GPIO_FN_D2_NAF2,
-	GPIO_FN_D3_NAF3,
-	GPIO_FN_D4_NAF4,
-	GPIO_FN_D5_NAF5,
-	GPIO_FN_D6_NAF6,
-	GPIO_FN_D7_NAF7,
-	GPIO_FN_D8_NAF8,
-	GPIO_FN_D9_NAF9,
-	GPIO_FN_D10_NAF10,
-	GPIO_FN_D11_NAF11,
-	GPIO_FN_D12_NAF12,
-	GPIO_FN_D13_NAF13,
-	GPIO_FN_D14_NAF14,
-	GPIO_FN_D15_NAF15,
-	GPIO_FN_CS4_,
-	GPIO_FN_CS5A_, GPIO_FN_PORT91_RDWR,
-	GPIO_FN_CS5B_, GPIO_FN_FCE1_,
-	GPIO_FN_CS6B_, GPIO_FN_DACK0,
-	GPIO_FN_FCE0_, GPIO_FN_CS6A_,
+	GPIO_FN_FCE1_,
+	GPIO_FN_DACK0,
+	GPIO_FN_FCE0_,
 	GPIO_FN_WAIT_, GPIO_FN_DREQ0,
-	GPIO_FN_RD__FSC,
-	GPIO_FN_WE0__FWE, GPIO_FN_RDWR_FWE,
-	GPIO_FN_WE1_,
 	GPIO_FN_FRB,
 	GPIO_FN_CKO,
 	GPIO_FN_NBRSTOUT_,
@@ -219,7 +198,7 @@ enum {
 	GPIO_FN_VIO2_CLK,
 	GPIO_FN_VIO_FIELD, GPIO_FN_VIO2_FIELD,
 	GPIO_FN_VIO_CKO,
-	GPIO_FN_A27, GPIO_FN_PORT149_RDWR, GPIO_FN_MFG0_IN1, \
+	GPIO_FN_A27, GPIO_FN_MFG0_IN1,
 	GPIO_FN_MFG0_IN2,
 	GPIO_FN_TS_SPSYNC3, GPIO_FN_MSIOF2_RSCK,
 	GPIO_FN_TS_SDAT3, GPIO_FN_MSIOF2_RSYNC,
-- 
1.7.10.4
