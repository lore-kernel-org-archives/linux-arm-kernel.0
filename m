From: fabrice.gasnier@st.com (Fabrice Gasnier)
Date: Tue, 17 Apr 2018 15:45:26 +0200
Subject: [PATCH 0/4] Add STM32 timers to stm32mp157c
Message-ID: <1523972730-29240-1-git-send-email-fabrice.gasnier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for STM32 timers to stm32mp157c. These
timers can act PWM, trigger and/or encoder.
Populate stm32mp157c SOC and ed1/ev1 boards.

Fabrice Gasnier (4):
  ARM: dts: stm32: add timers support to stm32mp157c
  ARM: dts: stm32: add PWM pins used on stm32mp157c-ev1 board
  ARM: dts: stm32: add PWM and triggers on stm32mp157c-ev1 board
  ARM: dts: stm32: enable timer trigger 6 on stm32mp157c-ed1

 arch/arm/boot/dts/stm32mp157-pinctrl.dtsi |  27 +++
 arch/arm/boot/dts/stm32mp157c-ed1.dts     |   7 +
 arch/arm/boot/dts/stm32mp157c-ev1.dts     |  36 ++++
 arch/arm/boot/dts/stm32mp157c.dtsi        | 283 ++++++++++++++++++++++++++++++
 4 files changed, 353 insertions(+)

-- 
1.9.1
