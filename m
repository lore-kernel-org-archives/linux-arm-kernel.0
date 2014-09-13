From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sat, 13 Sep 2014 20:40:58 +0200
Subject: [GIT PULL] second bunch of dts changes for 3.18
Message-ID: <2327307.ElC8r2sVBq@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof

here is a second stack of dts changes for Rockchip SoCs adding usb, spi
and emmc support. So please pull


The following changes since commit f23a6179d45e9d144bf2eb2bd82b2f1270f85fcf:

  ARM: dts: rockchip: add saradc nodes (2014-08-27 23:43:01 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v3.18-rockchip-dts2

for you to fetch changes up to 71557d70b3c1c391ade6622a1369a3f2b695a1d8:

  ARM: dts: rockchip: clean up rk3xxx mmc nodes (2014-09-13 20:28:20 +0200)

----------------------------------------------------------------
More peripheral support for Rockchip SoCs
- dwc2 usb controllers
- spi controllers
- emmc controller

----------------------------------------------------------------
Addy Ke (1):
      ARM: dts: Add sdio0 and sdio1 to the rk3288

Doug Anderson (3):
      ARM: dts: Add mshc aliases for rk3288
      ARM: dts: Add rk808 PMIC to rk3288-evb-rk808
      ARM: dts: Switch i2c0 to 400kHz on rk3288-evb-rk808

Heiko Stuebner (6):
      ARM: dts: rockchip: remove rockchip,bus-index from rk3xxx i2c0
      ARM: dts: rockchip: add dwc2 controllers for rk3066 and rk3188
      ARM: dts: rockchip: enable usb ports on Radxa Rock
      ARM: dts: rockchip: add Cortex-A9 SPI controller nodes
      ARM: dts: rockchip: add emmc nodes for rk3066 and rk3188
      ARM: dts: rockchip: clean up rk3xxx mmc nodes

Kever Yang (2):
      ARM: dts: add rk3288 dwc2 controller support
      ARM: dts: Enable USB host1(dwc) on rk3288-evb

huang lin (1):
      ARM: dts: Add SPI nodes to rk3288

 arch/arm/boot/dts/rk3066a.dtsi         |  67 ++++++++++
 arch/arm/boot/dts/rk3188-radxarock.dts |  43 +++++++
 arch/arm/boot/dts/rk3188.dtsi          |  69 +++++++++++
 arch/arm/boot/dts/rk3288-evb-rk808.dts | 132 ++++++++++++++++++++
 arch/arm/boot/dts/rk3288-evb.dtsi      |   4 +
 arch/arm/boot/dts/rk3288.dtsi          | 218 +++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/rk3xxx.dtsi          |  61 ++++++++-
 7 files changed, 589 insertions(+), 5 deletions(-)
