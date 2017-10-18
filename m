From: fabrice.gasnier@st.com (Fabrice Gasnier)
Date: Wed, 18 Oct 2017 13:39:27 +0200
Subject: [PATCH] iio: adc: stm32: add tim15 trigger
Message-ID: <1508326767-24215-1-git-send-email-fabrice.gasnier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add TIM15_TRGO trigger that is now supported on STM32H7.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/iio/adc/stm32-adc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index cc7ca50..4725756 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -501,6 +501,7 @@ struct stm32_adc_info {
 	{ TIM2_TRGO, STM32_EXT11 },
 	{ TIM4_TRGO, STM32_EXT12 },
 	{ TIM6_TRGO, STM32_EXT13 },
+	{ TIM15_TRGO, STM32_EXT14 },
 	{ TIM3_CH4, STM32_EXT15 },
 	{ LPTIM1_OUT, STM32_EXT18 },
 	{ LPTIM2_OUT, STM32_EXT19 },
-- 
1.9.1
