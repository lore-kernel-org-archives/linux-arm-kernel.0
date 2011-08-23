From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 23 Aug 2011 13:56:58 +0200
Subject: [GIT PULL] i.MX features for next
Message-ID: <20110823115658.GK31404@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Please pull the following feature patches for next.

Sascha

The following changes since commit 322a8b034003c0d46d39af85bf24fee27b902f48:

  Linux 3.1-rc1 (2011-08-07 18:23:30 -0700)

are available in the git repository at:
  git://git.pengutronix.de/git/imx/linux-2.6.git imx-features-for-arnd

Arnaud Patard (3):
      imx51: add pata device
      imx51: add pata clock
      imx: efika: Enable pata.

Dong Aisheng (5):
      ARM: mxs: add saif clock
      ARM: mxs: add saif device
      ARM: mxs: add sgtl5000 i2c device
      ARM: mxs: add mxs-sgtl5000 device
      ARM: mxs: correct the using of frac div for saif

Sascha Hauer (1):
      Merge branches 'features/imx-pata' and 'features/mxs' into imx-features

Wolfram Sang (3):
      arm: mxs: mx28evk: add fixed regulators for audio
      arm: mach-mxs: add device for rtc
      arm: mach-mxs: add rtc to all boards

 arch/arm/mach-mx5/Kconfig                         |    1 +
 arch/arm/mach-mx5/clock-mx51-mx53.c               |    5 ++
 arch/arm/mach-mx5/devices-imx51.h                 |    4 +
 arch/arm/mach-mx5/mx51_efika.c                    |    2 +
 arch/arm/mach-mxs/Kconfig                         |    6 ++
 arch/arm/mach-mxs/clock-mx28.c                    |    8 ++-
 arch/arm/mach-mxs/devices-mx23.h                  |    2 +
 arch/arm/mach-mxs/devices-mx28.h                  |    5 ++
 arch/arm/mach-mxs/devices/Kconfig                 |    6 ++
 arch/arm/mach-mxs/devices/Makefile                |    2 +
 arch/arm/mach-mxs/devices/platform-mxs-saif.c     |   60 ++++++++++++++++
 arch/arm/mach-mxs/devices/platform-rtc-stmp3xxx.c |   51 +++++++++++++
 arch/arm/mach-mxs/include/mach/devices-common.h   |   12 +++
 arch/arm/mach-mxs/mach-mx23evk.c                  |    1 +
 arch/arm/mach-mxs/mach-mx28evk.c                  |   78 +++++++++++++++++++++
 arch/arm/mach-mxs/mach-stmp378x_devb.c            |    1 +
 arch/arm/mach-mxs/mach-tx28.c                     |    1 +
 arch/arm/plat-mxc/devices/Kconfig                 |    3 +
 arch/arm/plat-mxc/devices/Makefile                |    1 +
 arch/arm/plat-mxc/devices/platform-pata_imx.c     |   38 ++++++++++
 arch/arm/plat-mxc/include/mach/devices-common.h   |    7 ++
 21 files changed, 292 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mach-mxs/devices/platform-mxs-saif.c
 create mode 100644 arch/arm/mach-mxs/devices/platform-rtc-stmp3xxx.c
 create mode 100644 arch/arm/plat-mxc/devices/platform-pata_imx.c
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
