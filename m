From: henrique@henriquecamargo.com (Henrique Camargo)
Date: Thu, 13 Sep 2012 15:04:36 -0300
Subject: [PATCH] davinci: fix the uart number in the comment
Message-ID: <1347559476-25363-1-git-send-email-henrique@henriquecamargo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The bit 0 of the field is uart0 and the bit 1 is uart1 and so on.

Signed-off-by: Henrique Camargo <henrique@henriquecamargo.com>
---
 arch/arm/mach-davinci/include/mach/serial.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-davinci/include/mach/serial.h b/arch/arm/mach-davinci/include/mach/serial.h
index 46b3cd1..86a01fa 100644
--- a/arch/arm/mach-davinci/include/mach/serial.h
+++ b/arch/arm/mach-davinci/include/mach/serial.h
@@ -38,7 +38,7 @@
 
 #ifndef __ASSEMBLY__
 struct davinci_uart_config {
-	/* Bit field of UARTs present; bit 0 --> UART1 */
+	/* Bit field of UARTs present; bit 0 --> UART0 */
 	unsigned int enabled_uarts;
 };
 
-- 
1.7.9.5
