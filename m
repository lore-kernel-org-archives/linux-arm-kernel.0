From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 11 Jul 2012 08:57:02 +0200
Subject: [GIT PULL] i.MX SoC updates for v3.6
Message-ID: <20120711065702.GH30009@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please pull the following i.MX SoC updates for 3.6.

Sascha



The following changes since commit bd0a521e88aa7a06ae7aabaed7ae196ed4ad867a:

  Linux 3.5-rc6 (2012-07-07 17:23:56 -0700)

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git tags/imx-soc

for you to fetch changes up to 0b87c1d4be230d109effe8aef78728160800e67f:

  ARM: imx: fix mx51 ehci setup errors (2012-07-09 10:32:44 +0200)

----------------------------------------------------------------
ARM i.MX SoC updates for 3.6

----------------------------------------------------------------
Alexander Shiyan (1):
      ARM: i.MX51 iomux: added missing pin definitions

Beno?t Th?baudeau (5):
      ARM: imx: fix i.MX35 CPU architecture
      ARM: imx: enable support for mx35 rtc
      ARM: imx: add rtc support to mx35_3ds
      ARM: imx: make ehci power/oc polarities configurable
      ARM: imx: fix mx51 ehci setup errors

 arch/arm/mach-imx/Kconfig                    |    3 ++-
 arch/arm/mach-imx/devices-imx35.h            |    4 ++++
 arch/arm/mach-imx/ehci-imx25.c               |   24 +++++++++++++++++---
 arch/arm/mach-imx/ehci-imx35.c               |   24 +++++++++++++++++---
 arch/arm/mach-imx/ehci-imx5.c                |   31 +++++++++++++++++++-------
 arch/arm/mach-imx/mach-mx35_3ds.c            |    1 +
 arch/arm/plat-mxc/devices/platform-mxc_rtc.c |    5 +++++
 arch/arm/plat-mxc/include/mach/iomux-mx51.h  |   14 ++++++++++++
 arch/arm/plat-mxc/include/mach/mxc_ehci.h    |   16 +++++++------
 9 files changed, 100 insertions(+), 22 deletions(-)
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
