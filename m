From: patrice.chotard@st.com (patrice.chotard at st.com)
Date: Thu, 1 Mar 2018 11:53:42 +0100
Subject: [PATCH v2 5/6] dt-bindings: mfd: Add STM32F7 SDMMC2 rcc entry
In-Reply-To: <1519901623-23216-1-git-send-email-patrice.chotard@st.com>
References: <1519901623-23216-1-git-send-email-patrice.chotard@st.com>
Message-ID: <1519901623-23216-6-git-send-email-patrice.chotard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrice Chotard <patrice.chotard@st.com>

STM32F769 SoC provides 2 SDMMC instances, add missing
RCC SDMMC2 entry for it.

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---
 include/dt-bindings/mfd/stm32f7-rcc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/mfd/stm32f7-rcc.h b/include/dt-bindings/mfd/stm32f7-rcc.h
index 8b7b7197ffd7..a90f3613c584 100644
--- a/include/dt-bindings/mfd/stm32f7-rcc.h
+++ b/include/dt-bindings/mfd/stm32f7-rcc.h
@@ -91,6 +91,7 @@
 #define STM32F7_RCC_APB2_TIM8		1
 #define STM32F7_RCC_APB2_USART1		4
 #define STM32F7_RCC_APB2_USART6		5
+#define STM32F7_RCC_APB2_SDMMC2		7
 #define STM32F7_RCC_APB2_ADC1		8
 #define STM32F7_RCC_APB2_ADC2		9
 #define STM32F7_RCC_APB2_ADC3		10
-- 
1.9.1
