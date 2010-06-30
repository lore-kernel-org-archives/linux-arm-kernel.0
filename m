From: siccegge@cs.fau.de (Christoph Egger)
Date: Wed, 30 Jun 2010 18:02:51 +0200
Subject: [PATCH 28/33] Removing dead CPU_S3C24XX
In-Reply-To: <cover.1277911345.git.siccegge@cs.fau.de>
References: <cover.1277911345.git.siccegge@cs.fau.de>
Message-ID: <787416813d524b042dc933fbcfbbae22fd5ca2ca.1277911346.git.siccegge@cs.fau.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CPU_S3C24XX doesn't exist in Kconfig, therefore removing all
references for it from the source code.

Signed-off-by: Christoph Egger <siccegge@cs.fau.de>
---
 arch/arm/mach-s3c2410/include/mach/gpio.h |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-s3c2410/include/mach/gpio.h b/arch/arm/mach-s3c2410/include/mach/gpio.h
index b649bf2..a37d274 100644
--- a/arch/arm/mach-s3c2410/include/mach/gpio.h
+++ b/arch/arm/mach-s3c2410/include/mach/gpio.h
@@ -30,8 +30,4 @@
 #include <mach/gpio-nrs.h>
 #include <mach/gpio-fns.h>
 
-#ifdef CONFIG_CPU_S3C24XX
-#define S3C_GPIO_END	(S3C2410_GPIO_BANKJ + 32)
-#else
 #define S3C_GPIO_END	(S3C2410_GPIO_BANKH + 32)
-#endif
-- 
1.7.0.4
