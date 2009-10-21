From: roel.kluin@gmail.com (Roel Kluin)
Date: Wed, 21 Oct 2009 13:25:50 +0200
Subject: [PATCH] pxa: Add missing underscores in define
Message-ID: <4ADEEFBE.2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Underscores were missing.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/arch/arm/mach-mmp/include/mach/mfp-pxa910.h b/arch/arm/mach-mmp/include/mach/mfp-pxa910.h
index bf1189f..7e8a80f 100644
--- a/arch/arm/mach-mmp/include/mach/mfp-pxa910.h
+++ b/arch/arm/mach-mmp/include/mach/mfp-pxa910.h
@@ -160,7 +160,7 @@
 #define MMC1_WP_MMC1_WP		MFP_CFG_DRV(MMC1_WP, AF0, MEDIUM)
 
 /* PWM */
-#define GPIO27 PWM3 AF2		MFP_CFG(GPIO27, AF2)
+#define GPIO27_PWM3_AF2		MFP_CFG(GPIO27, AF2)
 #define GPIO51_PWM2_OUT		MFP_CFG(GPIO51, AF2)
 #define GPIO117_PWM1_OUT	MFP_CFG(GPIO117, AF2)
 #define GPIO118_PWM2_OUT	MFP_CFG(GPIO118, AF2)
