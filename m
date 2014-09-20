From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 20 Sep 2014 22:26:00 +0200
Subject: [GIT PULL] Allwinner DT additions for 3.18
Message-ID: <20140920202600.GA19359@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

Please pull the DT additions for the Allwinner SoC for the next merge window.

Thanks!
Maxime

The following changes since commit 7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9:

  Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-dt-for-3.18

for you to fetch changes up to d07fe967189ff7c32f5a78b4f28c2ccbab850091:

  ARM: dts: sun8i: Add DMA controller node (2014-09-20 12:39:13 +0200)

----------------------------------------------------------------
Allwinner DT Additions for 3.18

Mostly:
  - A23 bringup ongoing
  - New boards: HSG H702, Merrii A20 Hummingbird
  - sun(4|5|7)i DMA support
  - DT relicensing to a dual GPL/X11 license

----------------------------------------------------------------
Chen-Yu Tsai (18):
      ARM: dts: sun8i: add rtc device node
      ARM: dts: sun6i: add rtc device node
      ARM: dts: sun8i: Add PIO controller node to the sun8i dtsi
      ARM: dts: sun8i: Add R_PIO controller node to the dtsi
      ARM: dts: sun8i: Add pinmux set for uart0
      ARM: dts: sun8i: Add pin muxing option for R_UART
      ARM: dts: sun8i: ippo-q8h: Add pinctrl properties for R_UART
      ARM: dts: sun8i: Add mmc clocks to the dtsi
      ARM: dts: sun8i: Add pin-muxing info for the mmc controllers
      ARM: dts: sun8i: Add mmc controller nodes
      ARM: dts: sun8i: Enable mmc controller on ippo-q8h-v5
      ARM: dts: sun8i: Add pin-muxing info for the i2c controllers
      ARM: dts: sun8i: Add i2c controller nodes
      ARM: dts: sun8i: Enable i2c controllers on ippo-q8h-v5
      ARM: dt: sunxi: Remove i2c controller clock-frequency that matches default
      ARM: dts: sunxi: Add fixed 5V regulator
      ARM: dts: sun5i: Add DT for HSG H702 tablet board
      ARM: dts: sun8i: Add DMA controller node

Emilio L?pez (6):
      ARM: sun4i: dt: Add node to represent the DMA controller
      ARM: sun5i: dt: Add nodes to represent the DMA controllers
      ARM: sun7i: dt: Add node to represent the DMA controller
      ARM: sun4i: dt: enable DMA on SPI
      ARM: sun5i: dt: enable DMA on SPI
      ARM: sun7i: dt: enable DMA on SPI

FUKAUMI Naoki (1):
      ARM: sun7i: Add support for Olimex A20-OLinuXino-LIME

Maxime Ripard (3):
      ARM: sun6i: Relicense the A31 DTSI under GPLv2/X11
      ARM: sun7i: Relicense the A20 DTSI under GPLv2/X11
      ARM: sun8i: Relicense the A23 DTSI under GPLv2/X11

Wills Wang (2):
      ARM: dts: sun7i: Add uart3/4/5, i2c3 and spi2 pinmux
      ARM: dts: sun7i: Add Merrii A20 Hummingbird board

 arch/arm/boot/dts/Makefile                     |   3 +
 arch/arm/boot/dts/sun4i-a10.dtsi               |  19 +-
 arch/arm/boot/dts/sun5i-a10s.dtsi              |  17 +-
 arch/arm/boot/dts/sun5i-a13-hsg-h702.dts       | 130 ++++++++++++++
 arch/arm/boot/dts/sun5i-a13.dtsi               |  17 +-
 arch/arm/boot/dts/sun6i-a31.dtsi               |  56 +++++-
 arch/arm/boot/dts/sun7i-a20-hummingbird.dts    | 236 ++++++++++++++++++++++++
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts | 137 ++++++++++++++
 arch/arm/boot/dts/sun7i-a20.dtsi               | 102 +++++++++--
 arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts    |  41 +++++
 arch/arm/boot/dts/sun8i-a23.dtsi               | 237 ++++++++++++++++++++++++-
 arch/arm/boot/dts/sunxi-common-regulators.dtsi |   7 +
 12 files changed, 969 insertions(+), 33 deletions(-)
 create mode 100644 arch/arm/boot/dts/sun5i-a13-hsg-h702.dts
 create mode 100644 arch/arm/boot/dts/sun7i-a20-hummingbird.dts
 create mode 100644 arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140920/c0426ee0/attachment.sig>
