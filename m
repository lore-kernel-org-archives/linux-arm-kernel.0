From: m-karicheri2@ti.com (Murali Karicheri)
Date: Tue, 19 Nov 2013 19:43:13 -0500
Subject: [PATCH v2 0/4] 
Message-ID: <1384908197-4324-1-git-send-email-m-karicheri2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series add a K2HK (K2 Hawking/Kepler) EVM
dts file and make some updates to the existing dts
files and Keystone PLL clk driver.

Murali Karicheri (4):
  clk: keystone: use clkod register bits for postdiv
  keystone: dts: add a k2hk-evm specific dts file
  keystone: dts: fix typo in the ddr3 pllclk node name
  keystone: dts: add paclk divider clock node

 .../devicetree/bindings/clock/keystone-pll.txt     |    8 +--
 arch/arm/boot/dts/k2hk-evm.dts                     |   55 ++++++++++++++++++++
 arch/arm/boot/dts/keystone-clocks.dtsi             |   36 ++++++-------
 arch/arm/boot/dts/{keystone.dts => keystone.dtsi}  |    2 -
 drivers/clk/keystone/pll.c                         |   24 +++++++--
 5 files changed, 96 insertions(+), 29 deletions(-)
 create mode 100644 arch/arm/boot/dts/k2hk-evm.dts
 rename arch/arm/boot/dts/{keystone.dts => keystone.dtsi} (98%)

-- 
1.7.9.5
