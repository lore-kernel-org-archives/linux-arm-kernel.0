From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Wed,  3 Feb 2016 12:04:41 +0100
Subject: [PATCH v5 5/9] ARM: mach-stm32: Select pinctrl
In-Reply-To: <1454497485-464-1-git-send-email-mcoquelin.stm32@gmail.com>
References: <1454497485-464-1-git-send-email-mcoquelin.stm32@gmail.com>
Message-ID: <1454497485-464-6-git-send-email-mcoquelin.stm32@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Patrice Chotard <patrice.chotard@st.com>
Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index ca16120..84b7291 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -879,6 +879,7 @@ config ARCH_STM32
 	select ARCH_HAS_RESET_CONTROLLER
 	select ARMV7M_SYSTICK
 	select CLKSRC_STM32
+	select PINCTRL
 	select RESET_CONTROLLER
 	help
 	  Support for STMicroelectronics STM32 processors.
-- 
1.9.1
