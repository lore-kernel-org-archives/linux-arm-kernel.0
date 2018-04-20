From: pierre-yves.mordret@st.com (Pierre-Yves MORDRET)
Date: Fri, 20 Apr 2018 11:14:39 +0200
Subject: [PATCH v1 2/4] ARM: configs: stm32: Add DMAMUX support on STM32MP157C
In-Reply-To: <1524215681-14555-1-git-send-email-pierre-yves.mordret@st.com>
References: <1524215681-14555-1-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <1524215681-14555-3-git-send-email-pierre-yves.mordret@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds DMAMUX support on STM32MP157C

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
index e5ac842..b746bf7 100644
--- a/arch/arm/mach-stm32/Kconfig
+++ b/arch/arm/mach-stm32/Kconfig
@@ -47,6 +47,7 @@ if ARCH_MULTI_V7
 config MACH_STM32MP157
 	bool "STMicroelectronics STM32MP157"
 	select STM32_DMA
+	select STM32_DMAMUX
 	default y
 
 endif # ARMv7-A
-- 
2.7.4
