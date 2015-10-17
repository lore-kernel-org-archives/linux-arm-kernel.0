From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Sat, 17 Oct 2015 19:23:20 +0200
Subject: [PATCH v2 5/9] ARM: mach-stm32: Select pinctrl
In-Reply-To: <1445102604-11502-1-git-send-email-mcoquelin.stm32@gmail.com>
References: <1445102604-11502-1-git-send-email-mcoquelin.stm32@gmail.com>
Message-ID: <1445102604-11502-6-git-send-email-mcoquelin.stm32@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index bf94e54..8a764ba 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -984,6 +984,7 @@ config ARCH_STM32
 	select ARCH_HAS_RESET_CONTROLLER
 	select ARMV7M_SYSTICK
 	select CLKSRC_STM32
+	select PINCTRL
 	select RESET_CONTROLLER
 	help
 	  Support for STMicroelectronics STM32 processors.
-- 
1.9.1
