From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 13 Feb 2013 11:44:56 +0900
Subject: [PATCH 20/21] ARM: shmobile: r8a7779: Remove DU1_DOTCLKOUT1 GPIO
In-Reply-To: <1360723497-23266-1-git-send-email-horms+renesas@verge.net.au>
References: <1360723497-23266-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1360723497-23266-21-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The function is not documented in the r8a7779 datasheet. Remove it.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/include/mach/r8a7779.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/include/mach/r8a7779.h b/arch/arm/mach-shmobile/include/mach/r8a7779.h
index 8ab0cd6..badba57 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7779.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7779.h
@@ -308,7 +308,7 @@ enum {
 	GPIO_FN_SD2_CD, GPIO_FN_MT0_VCXO, GPIO_FN_SPA_TMS, GPIO_FN_HSPI_TX1_D,
 	GPIO_FN_VI1_DATA7_VI1_B7, GPIO_FN_SD2_WP, GPIO_FN_MT0_PWM,
 	GPIO_FN_SPA_TDI, GPIO_FN_HSPI_RX1_D, GPIO_FN_VI1_G0, GPIO_FN_VI3_DATA0,
-	GPIO_FN_DU1_DOTCLKOUT1, GPIO_FN_TS_SCK1, GPIO_FN_DREQ2_B, GPIO_FN_TX2,
+	GPIO_FN_TS_SCK1, GPIO_FN_DREQ2_B, GPIO_FN_TX2,
 	GPIO_FN_SPA_TDO, GPIO_FN_HCTS0_B, GPIO_FN_VI1_G1, GPIO_FN_VI3_DATA1,
 	GPIO_FN_SSI_SCK1, GPIO_FN_TS_SDEN1, GPIO_FN_DACK2_B, GPIO_FN_RX2,
 	GPIO_FN_HRTS0_B,
-- 
1.7.10.4
