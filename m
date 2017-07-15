From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 15 Jul 2017 19:50:55 +0200
Subject: [PATCH 4/5] ARM: gemini: select pin controller
In-Reply-To: <20170715175056.13040-1-linus.walleij@linaro.org>
References: <20170715175056.13040-1-linus.walleij@linaro.org>
Message-ID: <20170715175056.13040-4-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Gemini needs its pin controller for the platform to work properly.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-gemini/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-gemini/Kconfig b/arch/arm/mach-gemini/Kconfig
index 42399af1ab60..70106b67631c 100644
--- a/arch/arm/mach-gemini/Kconfig
+++ b/arch/arm/mach-gemini/Kconfig
@@ -9,6 +9,8 @@ menuconfig ARCH_GEMINI
 	select FTTMR010_TIMER
 	select GPIO_FTGPIO010
 	select GPIOLIB
+	select PINCTRL
+	select PINCTRL_GEMINI
 	select POWER_RESET
 	select POWER_RESET_GEMINI_POWEROFF
 	select POWER_RESET_SYSCON
-- 
2.9.4
