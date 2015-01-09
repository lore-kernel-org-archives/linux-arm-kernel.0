From: maxime.coquelin@st.com (Maxime COQUELIN)
Date: Fri,  9 Jan 2015 16:11:43 +0100
Subject: [PATCH 0/3] Add STiH418 SoC and reference board support
Message-ID: <1420816306-11305-1-git-send-email-maxime.coquelin@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds basic support to the STMicroelectronics STiH407 SoC and its
B2199 reference board. The STiH418 is a quad-core ARM Cortex-A9 CPU aimed at
UHD STB market.

Maxime Coquelin (3):
  ARM: STi: Add STiH418 SoC support
  ARM: dts: Add STiH418 SoC support
  ARM: dts: STiH418: Add B2199 board support

 Documentation/arm/sti/stih418-overview.txt    |  20 ++
 Documentation/devicetree/bindings/arm/sti.txt |   4 +
 arch/arm/boot/dts/Makefile                    |   3 +-
 arch/arm/boot/dts/stih418-b2199.dts           |  78 ++++++
 arch/arm/boot/dts/stih418-clock.dtsi          | 348 ++++++++++++++++++++++++++
 arch/arm/boot/dts/stih418.dtsi                |  99 ++++++++
 arch/arm/mach-sti/board-dt.c                  |   1 +
 include/dt-bindings/clock/stih418-clks.h      |  34 +++
 8 files changed, 586 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/arm/sti/stih418-overview.txt
 create mode 100644 arch/arm/boot/dts/stih418-b2199.dts
 create mode 100644 arch/arm/boot/dts/stih418-clock.dtsi
 create mode 100644 arch/arm/boot/dts/stih418.dtsi
 create mode 100644 include/dt-bindings/clock/stih418-clks.h

-- 
1.9.1
