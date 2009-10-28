From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 28 Oct 2009 12:15:47 +0000
Subject: [PATCH 06/12] ARM: S3C64XX: Fix S3C64XX_CLKDIV0_ARM_MASK value
In-Reply-To: <1256732153-22027-1-git-send-email-ben-linux@fluff.org>
References: <1256732153-22027-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1256732153-22027-6-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kukjin Kim <kgene.kim@samsung.com>

Fix the values of S3C6400_CLKDIV0_ARM_MASK and S3C6410_CLKDIV0_ARM_MASK.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Ben Dooks <ben-linux@fluff.org>
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
1.6.3.3
