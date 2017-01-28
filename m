From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 28 Jan 2017 21:48:38 +0100
Subject: [PATCH 3/4] ARM: gemini: select MIGHT_HAVE_PCI
In-Reply-To: <20170128204839.18330-1-linus.walleij@linaro.org>
References: <20170128204839.18330-1-linus.walleij@linaro.org>
Message-ID: <20170128204839.18330-3-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As we have a PCI driver for the Gemini, we should select
MIGHT_HAVE_PCI.

Cc: Janos Laube <janos.dev@gmail.com>
Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
PCI maintainers: this is FYI only, I will funnel this to the ARM
SoC tree once we are done with the PCI driver.
---
 arch/arm/mach-gemini/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-gemini/Kconfig b/arch/arm/mach-gemini/Kconfig
index 798abb16bb88..91ea52ccf13c 100644
--- a/arch/arm/mach-gemini/Kconfig
+++ b/arch/arm/mach-gemini/Kconfig
@@ -5,6 +5,7 @@ menuconfig ARCH_GEMINI
 	select GEMINI_TIMER
 	select GPIO_GEMINI
 	select GPIOLIB
+	select MIGHT_HAVE_PCI
 	select POWER_RESET
 	select POWER_RESET_SYSCON
 	select SERIAL_OF_PLATFORM
-- 
2.9.3
