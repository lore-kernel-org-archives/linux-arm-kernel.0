From: chris.paterson2@renesas.com (Chris Paterson)
Date: Wed, 13 Sep 2017 18:05:33 +0100
Subject: [PATCH 0/8] ARM: renesas: Latest r8a774[35] dts updates
Message-ID: <1505322341-9480-1-git-send-email-chris.paterson2@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series contains multiple additions to the r8a774[35] device trees.

I've bundled them into a series to help avoid merge issues due to multiple
changes to the same files. Hopefully this doesn't add too much confusion!


Kind regards, Chris


Fabrizio Castro (8):
  ARM: dts: r8a7745: Add APMU node and second CPU core
  ARM: dts: r8a7745: Add SDHI controllers
  ARM: dts: iwg22m: Enable SDHI1 controller
  ARM: dts: iwg22d: Enable SDHI0 controller
  ARM: dts: r8a7743: Add QSPI support
  ARM: dts: iwg20m: Add SPI NOR support
  ARM: dts: r8a7745: Add QSPI support
  ARM: drs: iwg22m: Add SPI NOR support

 arch/arm/boot/dts/r8a7743-iwg20m.dtsi       | 26 ++++++++++
 arch/arm/boot/dts/r8a7743.dtsi              | 17 +++++++
 arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts | 37 ++++++++++++++
 arch/arm/boot/dts/r8a7745-iwg22m.dtsi       | 43 +++++++++++++++++
 arch/arm/boot/dts/r8a7745.dtsi              | 75 +++++++++++++++++++++++++++++
 5 files changed, 198 insertions(+)

-- 
1.9.1
