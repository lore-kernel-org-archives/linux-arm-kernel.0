From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 15 Aug 2016 13:17:33 +0100
Subject: [PATCH 0/7] ARM: dts: STi: Make way for new Linaro 96Board: ST B2260
Message-ID: <20160815121740.29515-1-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series paves the way for the new Linaro B2260 96Board, designed
and built by ST-Microelectronics.

Patrice Chotard (7):
  ARM: dts: STiH407: Move pio20 node to fix kernel warning
  ARM: dts: STiH410: Add thermal node
  ARM: dts: STiH407-pinctrl: Add i2c2_alt2_1 node
  ARM: dts: STiH407: Move non-removable property to board file
  ARM: dts: STiH407-pinctrl: Add pinctrl_rgmii1_mdio_1 node
  ARM: dts: STiH407-family: Add ports-implemented property in sata nodes
  ARM: dts: STi: Introduce B2260 board

 arch/arm/boot/dts/Makefile             |   1 +
 arch/arm/boot/dts/stih407-family.dtsi  |   5 +-
 arch/arm/boot/dts/stih407-pinctrl.dtsi |  32 ++++--
 arch/arm/boot/dts/stih410-b2260.dts    | 190 +++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/stih410.dtsi         |   8 ++
 arch/arm/boot/dts/stih418-b2199.dts    |   1 +
 arch/arm/boot/dts/stihxxx-b2120.dtsi   |   1 +
 7 files changed, 228 insertions(+), 10 deletions(-)
 create mode 100644 arch/arm/boot/dts/stih410-b2260.dts

-- 
2.9.0
