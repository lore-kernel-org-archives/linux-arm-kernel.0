From: gabriel.fernandez@st.com (gabriel.fernandez at st.com)
Date: Mon, 7 Nov 2016 14:05:37 +0100
Subject: [PATCH 0/6] Add STM32F4 missing clocks
Message-ID: <1478523943-23142-1-git-send-email-gabriel.fernandez@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

This patch-set adds:
 - I2S & SAI PLLs
 - SDIO & 48 Mhz clocks
 - LCD-TFT clock
 - I2S & SAI clocks


Gabriel Fernandez (6):
  clk: stm32f4: Add PLL_I2S & PLL_SAI for STM32F429/469 boards
  clk: stm32f4: SDIO & 48Mhz clock management for STM32F469 board
  clk: stm32f4: Add post divisor for I2S & SAI PLLs and Add lcd-tft
    clock
  clk: stm32f4: Add I2S clock
  clk: stm32f4: Add SAI clocks
  arm: dts: stm32f4: Add external I2S clock

 arch/arm/boot/dts/stm32f429.dtsi |   8 +-
 drivers/clk/clk-stm32f4.c        | 441 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 434 insertions(+), 15 deletions(-)

-- 
1.9.1
