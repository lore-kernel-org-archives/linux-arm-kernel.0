From: jsgood.yang@samsung.com (=?UTF-8?B?7JaR7KeE7ISx?=)
Date: Sat, 05 Sep 2009 22:24:12 +0900
Subject: [PATCH 01/12] [ARM][S3C6410] keypad memory map support
Message-ID: <00a001ca2e2c$28b48b80$7a1da280$%yang@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch introduces keypad memory map for new keypad driver.
Also the new keypad driver will be provided to the mainline soon.

Signed-off-by: Jinsung Yang <jsgood.yang@samsung.com>
Signed-off-by: Kyeongil Kim <ki0351.kim@samsung.com>
---
 arch/arm/mach-s3c6400/include/mach/map.h |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c6400/include/mach/map.h b/arch/arm/mach-s3c6400/include/mach/map.h
index 5057d99..d935570 100644
--- a/arch/arm/mach-s3c6400/include/mach/map.h
+++ b/arch/arm/mach-s3c6400/include/mach/map.h
@@ -65,6 +65,10 @@
 #define S3C_VA_VIC0		(S3C_VA_IRQ + 0x00)
 #define S3C_VA_VIC1		(S3C_VA_IRQ + 0x10000)
 
+/* keypad */
+#define S3C64XX_PA_KEYPAD	(0x7E00A000)
+#define S3C64XX_SZ_KEYPAD	SZ_4K
+
 /* compatibiltiy defines. */
 #define S3C_PA_TIMER		S3C64XX_PA_TIMER
 #define S3C_PA_HSMMC0		S3C64XX_PA_HSMMC0
@@ -75,5 +79,7 @@
 #define S3C_PA_FB		S3C64XX_PA_FB
 #define S3C_PA_USBHOST		S3C64XX_PA_USBHOST
 #define S3C_PA_USB_HSOTG	S3C64XX_PA_USB_HSOTG
+#define S3C_PA_KEYPAD		S3C64XX_PA_KEYPAD
+#define S3C_SZ_KEYPAD		S3C64XX_SZ_KEYPAD
 
 #endif /* __ASM_ARCH_6400_MAP_H */
-- 
1.6.2.5
