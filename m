From: alexandre.torgue@st.com (Alexandre TORGUE)
Date: Tue, 31 Jan 2017 14:14:23 +0100
Subject: [PATCH 6/8] ARM: stm32: Introduce MACH_STM32H743 flag
In-Reply-To: <1485868465-30446-1-git-send-email-alexandre.torgue@st.com>
References: <1485868465-30446-1-git-send-email-alexandre.torgue@st.com>
Message-ID: <1485868465-30446-7-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch introduces the MACH_STM32H743 to make possible to only select
STM32H743 pinctrl driver

By default, all the MACH_STM32Fxxx flags will be set with STM32 defconfig.

Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>

diff --git a/arch/arm/mach-stm32/Kconfig b/arch/arm/mach-stm32/Kconfig
index 40115fa..2d1419e 100644
--- a/arch/arm/mach-stm32/Kconfig
+++ b/arch/arm/mach-stm32/Kconfig
@@ -19,3 +19,8 @@ config MACH_STM32F746
 	bool "STMicrolectronics STM32F746"
 	depends on ARCH_STM32
 	default y
+
+config MACH_STM32H743
+	bool "STMicrolectronics STM32H743"
+	depends on ARCH_STM32
+	default y
-- 
1.9.1
