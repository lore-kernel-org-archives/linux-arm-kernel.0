From: thomas.ab@samsung.com (Thomas Abraham)
Date: Sun,  1 Nov 2009 13:50:31 +0900
Subject: [PATCH 2/7] S3C64XX: Add MEM_SYS_CFG register definition.
Message-ID: <1257051031-8074-1-git-send-email-thomas.ab@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the definition of MEM_SYS_CFG register for
S3C64xx platform.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
---
 arch/arm/plat-s3c64xx/include/plat/regs-clock.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-s3c64xx/include/plat/regs-clock.h b/arch/arm/plat-s3c64xx/include/plat/regs-clock.h
index 2c3224c..ad0823e 100644
--- a/arch/arm/plat-s3c64xx/include/plat/regs-clock.h
+++ b/arch/arm/plat-s3c64xx/include/plat/regs-clock.h
@@ -15,6 +15,8 @@
 #ifndef __PLAT_REGS_CLOCK_H
 #define __PLAT_REGS_CLOCK_H __FILE__
 
+#include <plat/map-base.h>
+
 #define S3C_CLKREG(x)		(S3C_VA_SYS + (x))
 
 #define S3C_APLL_LOCK		S3C_CLKREG(0x00)
@@ -33,6 +33,7 @@
 #define S3C_PCLK_GATE		S3C_CLKREG(0x34)
 #define S3C_SCLK_GATE		S3C_CLKREG(0x38)
 #define S3C_MEM0_GATE		S3C_CLKREG(0x3C)
+#define S3C_MEM_SYS_CFG         S3C_CLKREG(0x120)
 
 /* CLKDIV0 */
 #define S3C6400_CLKDIV0_MFC_MASK	(0xf << 28)
-- 
1.5.3.4
