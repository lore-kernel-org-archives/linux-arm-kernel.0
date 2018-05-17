From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Thu, 17 May 2018 14:07:05 +0200
Subject: [PATCH v2 0/3] Add STM32 RTC to stm32mp157c
Message-ID: <1526558828-24456-1-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for STM32 RTC to stm32mp157c SoC and enables it
on stm32mp157c-ed1 board.

---
Changes in v2:
* Enable STM32 RTC in multi_v7_defconfig

Amelie Delaunay (3):
  ARM: dts: stm32: add RTC support to stm32mp157c
  ARM: dts: stm32: enable RTC on stm32mp157c-ed1
  ARM: multi_v7_defconfig: enable STM32 RTC

 arch/arm/boot/dts/stm32mp157c-ed1.dts | 4 ++++
 arch/arm/boot/dts/stm32mp157c.dtsi    | 9 +++++++++
 arch/arm/configs/multi_v7_defconfig   | 1 +
 3 files changed, 14 insertions(+)

-- 
2.7.4
