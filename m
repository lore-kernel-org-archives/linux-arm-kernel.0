From: joel@jms.id.au (Joel Stanley)
Date: Mon,  9 May 2016 21:59:40 +0930
Subject: [PULL REQUEST] aspeed devicetree changes for 4.7
Message-ID: <1462796980-13703-1-git-send-email-joel@jms.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This device trees for a pair of Aspeed BMC SoCs and the boards that they sit
in.

Please pull if it looks okay.

The following changes since commit bf16200689118d19de1b8d2a3c314fc21f5dc7bb:

  Linux 4.6-rc3 (2016-04-10 17:58:30 -0700)

are available in the git repository at:

  https://github.com/shenki/linux.git tags/aspeed-for-4.7-dts

for you to fetch changes up to 02440622656d26a0d68308db9e4ce1d2510f6530:

  arm/dst: Add Aspeed ast2500 device tree (2016-05-09 17:41:58 +0930)

----------------------------------------------------------------
aspeed devicetree for 4.7

----------------------------------------------------------------
Joel Stanley (3):
      doc/devicetree: Add Aspeed and Tyan to vendor-prefixes
      arm/dts: Add Aspeed ast2400 device tree
      arm/dst: Add Aspeed ast2500 device tree

 .../devicetree/bindings/vendor-prefixes.txt        |   2 +
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/aspeed-ast2500-evb.dts           |  25 +++
 arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts      |  25 +++
 arch/arm/boot/dts/aspeed-g4.dtsi                   | 161 +++++++++++++++++++
 arch/arm/boot/dts/aspeed-g5.dtsi                   | 170 +++++++++++++++++++++
 6 files changed, 385 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed-ast2500-evb.dts
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts
 create mode 100644 arch/arm/boot/dts/aspeed-g4.dtsi
 create mode 100644 arch/arm/boot/dts/aspeed-g5.dtsi
