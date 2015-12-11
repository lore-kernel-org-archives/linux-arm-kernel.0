From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Fri, 11 Dec 2015 09:25:02 +0100
Subject: [PATCH v3 5/9] ARM: mach-stm32: Select pinctrl
In-Reply-To: <1449822306-9035-1-git-send-email-mcoquelin.stm32@gmail.com>
References: <1449822306-9035-1-git-send-email-mcoquelin.stm32@gmail.com>
Message-ID: <1449822306-9035-6-git-send-email-mcoquelin.stm32@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 4d2fcba..365714b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -963,6 +963,7 @@ config ARCH_STM32
 	select ARCH_HAS_RESET_CONTROLLER
 	select ARMV7M_SYSTICK
 	select CLKSRC_STM32
+	select PINCTRL
 	select RESET_CONTROLLER
 	help
 	  Support for STMicroelectronics STM32 processors.
-- 
1.9.1
