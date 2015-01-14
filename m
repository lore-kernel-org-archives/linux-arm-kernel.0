From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Wed, 14 Jan 2015 12:35:55 +0100
Subject: [PATCH 1/2] ARM: mediatek: Low-level-debug for mt6592
Message-ID: <1421235356-6631-1-git-send-email-matthias.bgg@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch changes the description of the low-level-debug port. SoC mt8127 and
mt6592 have the same uart port and the same mapping. We just change the
description to add low-level-debug to mt6592.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 arch/arm/Kconfig.debug | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 5ddd490..385f2d1 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -973,7 +973,7 @@ choice
 		  for Mediatek mt6589 based platforms on UART0.
 
 	config DEBUG_MT8127_UART0
-		bool "Mediatek mt8127 UART0"
+		bool "Mediatek mt8127/mt6592 UART0"
 		depends on ARCH_MEDIATEK
 		select DEBUG_UART_8250
 		help
-- 
1.9.1
