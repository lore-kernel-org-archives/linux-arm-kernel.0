From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Tue, 5 Feb 2013 22:50:18 +0100
Subject: [PATCH] ARM: S3C24XX: osiris: add missing platform_device.h include
Message-ID: <201302052250.18818.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The missing include led to a implcit declaration warning.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-s3c24xx/mach-osiris.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-s3c24xx/mach-osiris.c b/arch/arm/mach-s3c24xx/mach-osiris.c
index c2dc032..7d73626 100644
--- a/arch/arm/mach-s3c24xx/mach-osiris.c
+++ b/arch/arm/mach-s3c24xx/mach-osiris.c
@@ -21,6 +21,7 @@
 #include <linux/clk.h>
 #include <linux/i2c.h>
 #include <linux/io.h>
+#include <linux/platform_device.h>
 
 #include <linux/i2c/tps65010.h>
 
-- 
1.7.10.4
