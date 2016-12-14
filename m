From: gabriel.fernandez@st.com (gabriel.fernandez at st.com)
Date: Wed, 14 Dec 2016 15:23:17 +0100
Subject: [PATCH] dt-bindings: mfd: stm32f429: Add QSPI & DSI constants into DT
 include file
Message-ID: <1481725397-941-1-git-send-email-gabriel.fernandez@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

It will be used by clock and reset drivers, and DT bindings.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
---
 include/dt-bindings/mfd/stm32f4-rcc.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/dt-bindings/mfd/stm32f4-rcc.h b/include/dt-bindings/mfd/stm32f4-rcc.h
index e98942d..315f6c3 100644
--- a/include/dt-bindings/mfd/stm32f4-rcc.h
+++ b/include/dt-bindings/mfd/stm32f4-rcc.h
@@ -40,6 +40,7 @@
 
 /* AHB3 */
 #define STM32F4_RCC_AHB3_FMC	0
+#define STM32F4_RCC_AHB3_QSPI	1
 
 #define STM32F4_AHB3_RESET(bit)	(STM32F4_RCC_AHB3_##bit + (0x18 * 8))
 #define STM32F4_AHB3_CLOCK(bit)	(STM32F4_RCC_AHB3_##bit + (0x38 * 8))
@@ -91,6 +92,7 @@
 #define STM32F4_RCC_APB2_SPI6	21
 #define STM32F4_RCC_APB2_SAI1	22
 #define STM32F4_RCC_APB2_LTDC	26
+#define STM32F4_RCC_APB2_DSI	27
 
 #define STM32F4_APB2_RESET(bit)	(STM32F4_RCC_APB2_##bit + (0x24 * 8))
 #define STM32F4_APB2_CLOCK(bit)	(STM32F4_RCC_APB2_##bit + (0x44 * 8))
-- 
1.9.1
