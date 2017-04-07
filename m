From: alexandre.torgue@st.com (Alexandre TORGUE)
Date: Fri, 7 Apr 2017 14:43:03 +0200
Subject: [PATCH v2 6/7] ARM: Kconfig: Introduce MACH_STM32F469 flag
In-Reply-To: <1491568984-20169-1-git-send-email-alexandre.torgue@st.com>
References: <1491568984-20169-1-git-send-email-alexandre.torgue@st.com>
Message-ID: <1491568984-20169-7-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch introduces the MACH_STM32F469 to make possible to only select
STM32F469 pinctrl driver

By default, all the MACH_STM32Fxxx flags will be set with STM32 defconfig.

Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 0d4e71b..19c43e6 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -894,6 +894,11 @@ config MACH_STM32F429
 	depends on ARCH_STM32
 	default y
 
+config MACH_STM32F469
+	bool "STMicrolectronics STM32F469"
+	depends on ARCH_STM32
+	default y
+
 config MACH_STM32F746
 	bool "STMicrolectronics STM32F746"
 	depends on ARCH_STM32
-- 
1.9.1
