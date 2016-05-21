From: andrea.gelmini@gelma.net (Andrea Gelmini)
Date: Sat, 21 May 2016 13:51:51 +0200
Subject: [PATCH 0120/1529] Fix typo
Message-ID: <20160521115151.5653-1-andrea.gelmini@gelma.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/arm/mach-s3c64xx/include/mach/map.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-s3c64xx/include/mach/map.h b/arch/arm/mach-s3c64xx/include/mach/map.h
index f55ccb1..d51873e 100644
--- a/arch/arm/mach-s3c64xx/include/mach/map.h
+++ b/arch/arm/mach-s3c64xx/include/mach/map.h
@@ -99,7 +99,7 @@
 
 #define S3C64XX_PA_USB_HSPHY	(0x7C100000)
 
-/* compatibiltiy defines. */
+/* compatibility defines. */
 #define S3C_PA_TIMER		S3C64XX_PA_TIMER
 #define S3C_PA_HSMMC0		S3C64XX_PA_HSMMC0
 #define S3C_PA_HSMMC1		S3C64XX_PA_HSMMC1
-- 
2.8.2.534.g1f66975
