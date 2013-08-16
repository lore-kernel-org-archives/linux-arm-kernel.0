From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 16 Aug 2013 20:59:55 +0200
Subject: [GIT PULL] Allwinner sunXi DT additions for 3.12
Message-ID: <20130816185955.GA30005@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit ad81f0545ef01ea651886dddac4bef6cec930092:

  Linux 3.11-rc1 (2013-07-14 15:18:27 -0700)

are available in the git repository at:

  https://github.com/mripard/linux.git tags/sunxi-dt-for-3.12

for you to fetch changes up to 629ae88e9cebc6281bc54be743a33eca47b7228c:

  ARM: sunxi: dt: Add device tree for Mele A1000 (2013-08-14 09:59:20 +0200)

----------------------------------------------------------------
Allwinner sunXi DT additions for 3.12

  - Cleanups and few fixes to the DTSI
  - A few additions to the A10s olinuxino board

----------------------------------------------------------------
Emilio L?pez (6):
      ARM: sun5i: dt: Add I2C muxings for sun5i A10S
      ARM: sun5i: dt: Add I2C controller nodes to the A10S dtsi
      ARM: sun5i: dt: Enable I2C controllers on A10S-OLinuXino-Micro
      ARM: sun5i: dt: Add AT24 device on A10S-OLinuXino-Micro
      ARM: sunxi: make the leds' names conform to the current naming convention
      ARM: sunxi: dt: Add device tree for Mele A1000

Maxime Ripard (6):
      ARM: sun4i: a10: Remove useless simple-bus reg property
      ARM: sun4i: dt: Fix A10 SoC bus base address
      ARM: sun5i: a10s: Remove useless simple-bus reg property
      ARM: sun5i: dt: Fix A10s SoC bus base address
      ARM: sun5i: a13: Remove useless simple-bus reg property
      ARM: sun5i: dt: Fix A13 SoC bus base address

 arch/arm/boot/dts/Makefile                       |   1 +
 arch/arm/boot/dts/sun4i-a10-a1000.dts            | 101 +++++++++++++++++++++++
 arch/arm/boot/dts/sun4i-a10-cubieboard.dts       |   6 +-
 arch/arm/boot/dts/sun4i-a10-hackberry.dts        |   2 +-
 arch/arm/boot/dts/sun4i-a10-mini-xplus.dts       |   2 +-
 arch/arm/boot/dts/sun4i-a10.dtsi                 |   3 +-
 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts |  27 +++++-
 arch/arm/boot/dts/sun5i-a10s.dtsi                |  57 ++++++++++++-
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts        |   2 +-
 arch/arm/boot/dts/sun5i-a13.dtsi                 |   3 +-
 10 files changed, 191 insertions(+), 13 deletions(-)
 create mode 100644 arch/arm/boot/dts/sun4i-a10-a1000.dts

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130816/809c6d0c/attachment.sig>
