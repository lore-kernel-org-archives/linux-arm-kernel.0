From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Thu, 19 Jan 2017 14:45:16 +0100
Subject: [PATCH 0/3] Add RTC support on STM32F746
Message-ID: <1484833519-9298-1-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset enables STM32 RTC on STM32F746 MCU.

Amelie Delaunay (3):
  ARM: dts: stm32: set HSE_RTC clock frequency to 1 MHz on stm32f746
  ARM: dts: stm32: Add RTC support for STM32F746 MCU
  ARM: dts: stm32: enable RTC on stm32746g-eval

 arch/arm/boot/dts/stm32746g-eval.dts |  4 ++++
 arch/arm/boot/dts/stm32f746.dtsi     | 16 ++++++++++++++++
 2 files changed, 20 insertions(+)

-- 
1.9.1
