From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Thu, 19 Apr 2018 16:35:23 +0200
Subject: [PATCH 0/2] Add STM32 RTC to stm32mp157c
Message-ID: <1524148525-25209-1-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for STM32 RTC to stm32mp157c SoC and enable it
on stm32mp157c-ed1 board.

Amelie Delaunay (2):
  ARM: dts: stm32: add RTC support to stm32mp157c
  ARM: dts: stm32: enable RTC on stm32mp157c-ed1

 arch/arm/boot/dts/stm32mp157c-ed1.dts | 4 ++++
 arch/arm/boot/dts/stm32mp157c.dtsi    | 9 +++++++++
 2 files changed, 13 insertions(+)

-- 
2.7.4
