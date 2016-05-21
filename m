From: andrea.gelmini@gelma.net (Andrea Gelmini)
Date: Sat, 21 May 2016 13:51:23 +0200
Subject: [PATCH 0116/1529] Fix typo
Message-ID: <20160521115123.5447-1-andrea.gelmini@gelma.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/arm/mach-s3c24xx/include/mach/regs-gpio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-s3c24xx/include/mach/regs-gpio.h b/arch/arm/mach-s3c24xx/include/mach/regs-gpio.h
index c6583cf..0d622f3 100644
--- a/arch/arm/mach-s3c24xx/include/mach/regs-gpio.h
+++ b/arch/arm/mach-s3c24xx/include/mach/regs-gpio.h
@@ -520,7 +520,7 @@
 #define S3C24XX_EXTINT1	   S3C24XX_GPIOREG2(0x8C)
 #define S3C24XX_EXTINT2	   S3C24XX_GPIOREG2(0x90)
 
-/* interrupt filtering conrrol for EINT16..EINT23 */
+/* interrupt filtering control for EINT16..EINT23 */
 #define S3C2410_EINFLT0	   S3C2410_GPIOREG(0x94)
 #define S3C2410_EINFLT1	   S3C2410_GPIOREG(0x98)
 #define S3C2410_EINFLT2	   S3C2410_GPIOREG(0x9C)
-- 
2.8.2.534.g1f66975
