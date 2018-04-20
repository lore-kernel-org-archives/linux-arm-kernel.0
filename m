From: pierre-yves.mordret@st.com (Pierre-Yves MORDRET)
Date: Fri, 20 Apr 2018 11:14:38 +0200
Subject: [PATCH v1 1/4] ARM: configs: stm32: Add DMAv2 support on STM32MP157C
 machine
In-Reply-To: <1524215681-14555-1-git-send-email-pierre-yves.mordret@st.com>
References: <1524215681-14555-1-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <1524215681-14555-2-git-send-email-pierre-yves.mordret@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds DMAv2 support for STM32MP157C machine

Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
---
  Version history:
     v1:
        * Initial
---
---
 arch/arm/mach-stm32/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-stm32/Kconfig b/arch/arm/mach-stm32/Kconfig
index 713c068..e5ac842 100644
--- a/arch/arm/mach-stm32/Kconfig
+++ b/arch/arm/mach-stm32/Kconfig
@@ -46,6 +46,7 @@ if ARCH_MULTI_V7
 
 config MACH_STM32MP157
 	bool "STMicroelectronics STM32MP157"
+	select STM32_DMA
 	default y
 
 endif # ARMv7-A
-- 
2.7.4
