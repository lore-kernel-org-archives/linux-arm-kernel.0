From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 19 Jun 2013 11:40:32 +0200
Subject: [GIT PULL] Allwinner sunXi additions for 3.11, take 2
Message-ID: <20130619094032.GA7718@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Here is the second batch of DT patches for Allwinner SoCs for the next
merge window.

The following changes since commit 39138bc60f90560ac79e76fb0971be5619ae32d7:

  ARM: sunxi: dt: Register the pio node as interrupt controller (2013-06-10 17:35:51 +0200)

are available in the git repository at:

  git://github.com/mripard/linux.git tags/sunxi-dt-for-3.11-2

for you to fetch changes up to d0f2677be5b49a1c1de59fe94faa96b7808be95f:

  ARM: sunxi: Add Olimex A10s-Olinuxino-micro device tree (2013-06-19 11:01:39 +0200)

----------------------------------------------------------------
Allwinner SoCs DT additions for 3.11, part 2

Mostly adds support for the i2c controllers and the Allwinner A10S SoC.

----------------------------------------------------------------
Emilio L?pez (1):
      ARM: sun4i: cubieboard: Enable the i2c controllers

Maxime Ripard (6):
      ARM: sunxi: dt: Add i2c controller nodes to the DTSI
      ARM: sun4i: dt: Add i2c muxing options
      ARM: sun5i: dt: Add i2c muxing options
      ARM: sun5i: olinuxino: Enable the i2c controllers
      ARM: sunxi: dt: Add Allwinner A10s DTSI
      ARM: sunxi: Add Olimex A10s-Olinuxino-micro device tree

 arch/arm/boot/dts/Makefile                       |   1 +
 arch/arm/boot/dts/sun4i-a10-cubieboard.dts       |  12 +
 arch/arm/boot/dts/sun4i-a10.dtsi                 |  48 ++++
 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts |  76 ++++++
 arch/arm/boot/dts/sun5i-a10s.dtsi                | 286 +++++++++++++++++++++++
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts        |  18 ++
 arch/arm/boot/dts/sun5i-a13.dtsi                 |  48 ++++
 7 files changed, 489 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
 create mode 100644 arch/arm/boot/dts/sun5i-a10s.dtsi

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
