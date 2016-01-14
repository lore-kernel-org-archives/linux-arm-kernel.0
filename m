From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Thu, 14 Jan 2016 13:16:31 +0100
Subject: [PATCH v4 5/9] ARM: mach-stm32: Select pinctrl
In-Reply-To: <1452773795-24216-1-git-send-email-mcoquelin.stm32@gmail.com>
References: <1452773795-24216-1-git-send-email-mcoquelin.stm32@gmail.com>
Message-ID: <1452773795-24216-6-git-send-email-mcoquelin.stm32@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Patrice Chotard <patrice.chotard@st.com>
Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index b7aa567..f700a90 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -965,6 +965,7 @@ config ARCH_STM32
 	select ARCH_HAS_RESET_CONTROLLER
 	select ARMV7M_SYSTICK
 	select CLKSRC_STM32
+	select PINCTRL
 	select RESET_CONTROLLER
 	help
 	  Support for STMicroelectronics STM32 processors.
-- 
1.9.1
