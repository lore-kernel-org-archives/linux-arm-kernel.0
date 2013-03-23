From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 23 Mar 2013 10:48:05 +0100
Subject: [GIT PULL] sunxi DT additions for 3.10, take 1
Message-ID: <514D7A55.4080408@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

Please consider pulling the following pull request.

It contains several dt patches for the Allwinner platform, part of them
were the one that were not included in 3.9, plus the patches to enable
the allwinner clocks in the device tree.

Thanks,
Maxime

The following changes since commit 6dbe51c251a327e012439c4772097a13df43c5b8:

  Linux 3.9-rc1 (2013-03-03 15:11:05 -0800)

are available in the git repository at:

  git://github.com/mripard/linux.git tags/sunxi-dt-for-3.10

for you to fetch changes up to 2c3b4d7a354015403d61e8d690044700db963598:

  arm: sunxi: Add clock definitions for the new clock driver (2013-03-23 09:39:00 +0100)

----------------------------------------------------------------
Allwinner sunxi DT additions for 3.10

----------------------------------------------------------------
Emilio L?pez (2):
      sunxi: a10-cubieboard: Add user LEDs to the device tree
      arm: sunxi: Add clock definitions for the new clock driver

Maxime Ripard (3):
      sunxi: dts: Report the pinctrl nodes as gpio-controllers
      sunxi: a13-olinuxino: Add user LED to the device tree
      ARM: sunxi: dt: Add support for the PineRiver Mini X-plus

 arch/arm/boot/dts/sun4i-a10-cubieboard.dts |   26 +++++++++
 arch/arm/boot/dts/sun4i-a10-mini-xplus.dts |   32 +++++++++++
 arch/arm/boot/dts/sun4i-a10.dtsi           |    4 +-
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts  |   20 +++++++
 arch/arm/boot/dts/sun5i-a13.dtsi           |    4 +-
 arch/arm/boot/dts/sunxi.dtsi               |   83 +++++++++++++++++++++++++++-
 6 files changed, 164 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/boot/dts/sun4i-a10-mini-xplus.dts

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
