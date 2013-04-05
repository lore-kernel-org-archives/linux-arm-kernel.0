From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 05 Apr 2013 18:53:10 +0200
Subject: [GIT PULL] ARM: sunxi: dt for 3.10, take 2
Message-ID: <515F0176.6060601@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please consider merging the following branch for 3.10

The following changes since commit 2c3b4d7a354015403d61e8d690044700db963598:

  arm: sunxi: Add clock definitions for the new clock driver (2013-03-23 09:39:00 +0100)

are available in the git repository at:

  git://github.com/mripard/linux.git tags/sunxi-dt-for-3.10-2

for you to fetch changes up to 36386d6e54d0ebcd5b2e0869f837800293d94c3c:

  arm: sunxi: Add clock to pinctrl node (2013-04-04 23:45:30 +0200)

----------------------------------------------------------------
ARM: sunxi: dt additions for 3.10, take 2

  - Rename the clock compatible introduced in the first pull request for 3.10
  - Complete the UART support for A13 and A10
  - Adds clock gates support

----------------------------------------------------------------
Emilio L?pez (5):
      arm: sunxi: rename clock compatible strings
      ARM: sunxi: cubieboard: Add UART muxing
      arm: sunxi: Add clock definitions for AXI, AHB, APB0, APB1 gates
      arm: sunxi: use the right clock phandles for UARTs
      arm: sunxi: Add clock to pinctrl node

Maxime Ripard (6):
      ARM: sunxi: dt: Use clocks property instead of clock-frequency for the UARTs
      ARM: sunxi: Rename uart nodes to serial
      ARM: sunxi: dt: Move uart0 to sun4i-a10.dtsi
      ARM: sunxi: dt: Add uart3 dt node
      ARM: sunxi: dt: Add A10 UARTs to the dtsi.
      ARM: sunxi: hackberry: Add UART muxing

 arch/arm/boot/dts/sun4i-a10-cubieboard.dts |    8 ++-
 arch/arm/boot/dts/sun4i-a10-hackberry.dts  |    4 +-
 arch/arm/boot/dts/sun4i-a10.dtsi           |   61 +++++++++++++++++++++
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts  |    2 +-
 arch/arm/boot/dts/sun5i-a13.dtsi           |    1 +
 arch/arm/boot/dts/sunxi.dtsi               |   81 ++++++++++++++++++++++------
 6 files changed, 134 insertions(+), 23 deletions(-)


-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
