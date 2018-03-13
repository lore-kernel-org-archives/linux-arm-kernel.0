From: fabrice.gasnier@st.com (Fabrice Gasnier)
Date: Tue, 13 Mar 2018 15:23:04 +0100
Subject: [PATCH 0/2] iio: stm32-dfsdm-adc: fix filter & rate setting
Message-ID: <1520950986-23116-1-git-send-email-fabrice.gasnier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series brings fixes to STM32 DFSDM ADC driver.

Fabrice Gasnier (2):
  iio: adc: stm32-dfsdm: fix successive oversampling settings
  iio: adc: stm32-dfsdm: fix sample rate for div2 spi clock

 drivers/iio/adc/stm32-dfsdm-adc.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

-- 
1.9.1
