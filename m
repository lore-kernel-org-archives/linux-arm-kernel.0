From: afzal.mohd.ma@gmail.com (Afzal Mohammed)
Date: Wed, 11 Nov 2015 12:41:26 +0530
Subject: [PATCH] ARM: OMAP2+: AM43x debug_ll Kconfig help
Message-ID: <1447225886-2940-1-git-send-email-afzal.mohd.ma@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mention about AM43x debug_ll ports - same as AM335x.

Signed-off-by: Afzal Mohammed <afzal.mohd.ma@gmail.com>
---
 arch/arm/Kconfig.debug | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 259c0ca9c99a..adc40fccfafa 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -689,7 +689,7 @@ choice
 		select DEBUG_OMAP2PLUS_UART
 
 	config DEBUG_AM33XXUART1
-		bool "Kernel low-level debugging messages via AM33XX UART1"
+		bool "Kernel low-level debugging messages via AM335x/AM43x UART1"
 		depends on ARCH_OMAP2PLUS
 		select DEBUG_OMAP2PLUS_UART
 
-- 
2.5.1
