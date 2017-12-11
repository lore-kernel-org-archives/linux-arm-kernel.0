From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Mon, 11 Dec 2017 09:54:33 +0100
Subject: [PATCH 3/5] ARM: mach-stm32: Kconfig: introduce MACH_STM32F769 flag
In-Reply-To: <1512982475-32661-2-git-send-email-alexandre.torgue@st.com>
References: <1512982475-32661-2-git-send-email-alexandre.torgue@st.com>
Message-ID: <1512982475-32661-4-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch introduces the MACH_STM32F769 to make possible to only select
STM32F769 pinctrl driver.

By default, all the MACH_STM32Fxxx flags will be set with STM32 defconfig.

Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>

diff --git a/arch/arm/mach-stm32/Kconfig b/arch/arm/mach-stm32/Kconfig
index 0d1889b..33b07db3 100644
--- a/arch/arm/mach-stm32/Kconfig
+++ b/arch/arm/mach-stm32/Kconfig
@@ -25,6 +25,11 @@ config MACH_STM32F746
 	depends on ARCH_STM32
 	default y
 
+config MACH_STM32F769
+	bool "STMicroelectronics STM32F769"
+	depends on ARCH_STM32
+	default y
+
 config MACH_STM32H743
 	bool "STMicrolectronics STM32H743"
 	depends on ARCH_STM32
-- 
2.7.4
