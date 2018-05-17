From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Thu, 17 May 2018 17:47:30 +0200
Subject: [PATCH 0/2] Add USB OTG HS support on stm32mp157c
Message-ID: <1526572052-17155-1-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds support for USB OTG HS on stm32mp157c SoC.
It also enables USB OTG HS on stm32mp157c-ev1 board in Peripheral mode.

Amelie Delaunay (2):
  ARM: dts: stm32: add USB OTG HS support for stm32mp157c SoC
  ARM: dts: stm32: enable USB OTG HS on stm32mp157c-ev1

 arch/arm/boot/dts/stm32mp157c-ev1.dts |  7 +++++++
 arch/arm/boot/dts/stm32mp157c.dtsi    | 15 +++++++++++++++
 2 files changed, 22 insertions(+)

-- 
2.7.4
