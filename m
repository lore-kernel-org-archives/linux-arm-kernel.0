From: chunkeey@googlemail.com (Christian Lamparter)
Date: Tue, 28 Mar 2017 01:11:40 +0200
Subject: [PATCH] ARM: debug: qcom: add UART addresses to Kconfig help for
 IPQ4019
Message-ID: <20170327231140.3132-1-chunkeey@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add information about the IPQ4019 debug UART physical and virtual
addresses in the DEBUG_QCOM_UARTDM Kconfig help section.

Signed-off-by: Christian Lamparter <chunkeey@googlemail.com>
---
 arch/arm/Kconfig.debug | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 426d2716f55d..0e5c1f9c546a 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -751,6 +751,7 @@ choice
 		  ARCH      DEBUG_UART_PHYS   DEBUG_UART_VIRT
 		  APQ8064   0x16640000        0xf0040000
 		  APQ8084   0xf995e000        0xfa75e000
+		  IPQ4019   0x078af000        0xf78af000
 		  MSM8X60   0x19c40000        0xf0040000
 		  MSM8960   0x16440000        0xf0040000
 		  MSM8974   0xf991e000        0xfa71e000
-- 
2.11.0
