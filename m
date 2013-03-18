From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 20:07:17 +0900
Subject: [PATCH 141/142] ARM: shmobile: r8a7779: Remove LBSC function GPIOs
In-Reply-To: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
References: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363604838-29359-142-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Those GPIOs have been deprecated by the pinctrl API. They are unused and
unneeded, remove them.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/include/mach/r8a7779.h |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/r8a7779.h b/arch/arm/mach-shmobile/include/mach/r8a7779.h
index e50bf53..688c0d2 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7779.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7779.h
@@ -83,22 +83,20 @@ enum {
 	GPIO_FN_VI1_R2, GPIO_FN_SSI_WS78_B, GPIO_FN_A25,
 	GPIO_FN_FD5,
 	GPIO_FN_VI1_R3, GPIO_FN_SSI_SDATA7_B,
-	GPIO_FN_CLKOUT, GPIO_FN_PWM0_B, GPIO_FN_CS0,
-	GPIO_FN_CS1_A26,
+	GPIO_FN_CLKOUT, GPIO_FN_PWM0_B,
 	GPIO_FN_SDSELF_B, GPIO_FN_RD_WR, GPIO_FN_FWE, GPIO_FN_ATAG0,
 	GPIO_FN_VI1_R7, GPIO_FN_HRTS1,
 
 	/* IPSR1 */
-	GPIO_FN_EX_CS0,
-	GPIO_FN_FD6, GPIO_FN_EX_CS1, GPIO_FN_FD7,
-	GPIO_FN_EX_CS2, GPIO_FN_FALE,
-	GPIO_FN_ATACS00, GPIO_FN_EX_CS3,
+	GPIO_FN_FD6, GPIO_FN_FD7,
+	GPIO_FN_FALE,
+	GPIO_FN_ATACS00,
 	GPIO_FN_FRE, GPIO_FN_ATACS10, GPIO_FN_VI1_R4,
 	GPIO_FN_HSCK1, GPIO_FN_SSI_SDATA8_B,
-	GPIO_FN_SSI_SDATA9, GPIO_FN_EX_CS4,
+	GPIO_FN_SSI_SDATA9,
 	GPIO_FN_FD0, GPIO_FN_ATARD0, GPIO_FN_VI1_R5,
 	GPIO_FN_HTX1, GPIO_FN_SSI_SCK9,
-	GPIO_FN_EX_CS5, GPIO_FN_FD1,
+	GPIO_FN_FD1,
 	GPIO_FN_ATAWR0, GPIO_FN_VI1_R6, GPIO_FN_HRX1,
 	GPIO_FN_SSI_WS9, GPIO_FN_MLB_CLK, GPIO_FN_PWM2,
 	GPIO_FN_MLB_SIG, GPIO_FN_PWM3,
-- 
1.7.10.4
