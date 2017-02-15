From: fabrice.gasnier@st.com (Fabrice Gasnier)
Date: Wed, 15 Feb 2017 17:55:55 +0100
Subject: [PATCH 0/2] iio: allow to set STM32 ADC resolution 
Message-ID: <1487177757-19427-1-git-send-email-fabrice.gasnier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

STM32 ADC supports several resolution. Add dt option so resolution
can be tuned at probe time. By default, maximum resolution is used
when it isn't set.

Fabrice Gasnier (2):
  dt-bindings: iio: stm32-adc: add option to set resolution
  iio: adc: stm32: add dt option to set resolution

 .../devicetree/bindings/iio/adc/st,stm32-adc.txt   |  4 ++
 drivers/iio/adc/stm32-adc.c                        | 50 +++++++++++++++++++++-
 2 files changed, 53 insertions(+), 1 deletion(-)

-- 
1.9.1
