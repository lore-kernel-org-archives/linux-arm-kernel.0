From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Wed, 14 Oct 2015 09:24:42 +0200
Subject: [PATCH] ARM: at91: debug: update prompt for DEBUG_AT91_UART
Message-ID: <1444807482-22797-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add (read help!) to DEBUG_AT91_UART prompt. It is not obvious there are
such useful information to set DEBUG_UART_PHYS.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 arch/arm/Kconfig.debug | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 259c0ca..589e724 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -124,7 +124,7 @@ choice
 		    0x80024000      | 0xf0024000     | UART9
 
 	config DEBUG_AT91_UART
-		bool "Kernel low-level debugging on Atmel SoCs"
+		bool "Kernel low-level debugging on Atmel SoCs (read help!)"
 		depends on ARCH_AT91
 		help
 		  Say Y here if you want the debug print routines to direct
-- 
2.5.0
