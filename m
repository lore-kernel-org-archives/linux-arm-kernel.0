From: fabrice.gasnier@st.com (Fabrice Gasnier)
Date: Thu, 1 Feb 2018 14:44:35 +0100
Subject: [PATCH 0/3] Add pwm-cells on STM32 LPTimer
Message-ID: <1517492678-767-1-git-send-email-fabrice.gasnier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add missing generic #pwm-cells on STM32 LPTimer to allow initialization
of channel, period and polarity.

Fabrice Gasnier (1):
  ARM: dts: stm32: update pwm-cells for LPTimer on stm32h743

Gerald Baeza (2):
  dt-bindings: pwm-stm32-lp: add #pwm-cells
  pwm: stm32: LPTimer: use 3 cells xlate

 Documentation/devicetree/bindings/pwm/pwm-stm32-lp.txt | 3 +++
 arch/arm/boot/dts/stm32h743.dtsi                       | 5 +++++
 drivers/pwm/pwm-stm32-lp.c                             | 2 ++
 3 files changed, 10 insertions(+)

-- 
1.9.1
