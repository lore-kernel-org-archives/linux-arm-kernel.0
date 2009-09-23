From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 23 Sep 2009 12:59:07 +0900
Subject: [PATCH] s3c64xx: Fix S3C64XX_CLKDIV0_ARM_MASK value
Message-ID: <1253678347-16870-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the values of S3C6400_CLKDIV0_ARM_MASK and S3C6410_CLKDIV0_ARM_MASK.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/plat-s3c64xx/include/plat/regs-clock.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-s3c64xx/include/plat/regs-clock.h b/arch/arm/plat-s3c64xx/include/plat/regs-clock.h
index a8777a7..ff46e7f 100644
--- a/arch/arm/plat-s3c64xx/include/plat/regs-clock.h
+++ b/arch/arm/plat-s3c64xx/include/plat/regs-clock.h
@@ -51,8 +51,8 @@
 #define S3C6400_CLKDIV0_HCLK_SHIFT	(8)
 #define S3C6400_CLKDIV0_MPLL_MASK	(0x1 << 4)
 #define S3C6400_CLKDIV0_MPLL_SHIFT	(4)
-#define S3C6400_CLKDIV0_ARM_MASK	(0x3 << 0)
-#define S3C6410_CLKDIV0_ARM_MASK	(0x7 << 0)
+#define S3C6400_CLKDIV0_ARM_MASK	(0x7 << 0)
+#define S3C6410_CLKDIV0_ARM_MASK	(0xf << 0)
 #define S3C6400_CLKDIV0_ARM_SHIFT	(0)
 
 /* CLKDIV1 */
-- 
1.5.3.4
