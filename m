From: fabrice.gasnier@st.com (Fabrice Gasnier)
Date: Mon, 10 Jul 2017 15:23:56 +0200
Subject: [PATCH 0/4] Add support for STM32F4 DAC
Message-ID: <1499693040-12994-1-git-send-email-fabrice.gasnier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for STM32F4 Digital to Analog Converter variant into
existing STM32 DAC driver.
Introduce compatible associated with configuration data.
BTW, fix error message in driver probe (minor).

Fabrice Gasnier (4):
  dt-bindings: iio: stm32-dac: add support for STM32F4
  iio: dac: stm32: fix error message
  iio: dac: stm32: add support for stm32f4
  ARM: dts: stm32: Add DAC support on stm32f429

 .../devicetree/bindings/iio/dac/st,stm32-dac.txt   |  4 ++-
 arch/arm/boot/dts/stm32f429.dtsi                   | 25 ++++++++++++++
 drivers/iio/dac/stm32-dac-core.c                   | 38 ++++++++++++++++++----
 drivers/iio/dac/stm32-dac.c                        |  2 +-
 4 files changed, 60 insertions(+), 9 deletions(-)

-- 
1.9.1
