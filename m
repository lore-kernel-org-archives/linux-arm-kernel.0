From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 9 May 2012 09:18:34 +0200
Subject: [GIT PULL] i.MX Eukrea board patches
Message-ID: <20120509071834.GF27341@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Arnd, Olof,

Please pull the following i.MX Eukrea board updates for next.

Thanks
 Sascha

The following changes since commit 66f75a5d028beaf67c931435fdc3e7823125730c:

  Linux 3.4-rc4 (2012-04-21 14:47:52 -0700)

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git tags/imx-eukrea

for you to fetch changes up to 53a02d11f1bc9c2c692908d2eda3f3fb34f9bf9d:

  ARM: imx: eukrea_mbimxsd rename to eukrea_mbimxsd51 (2012-05-08 17:31:25 +0200)

----------------------------------------------------------------
ARM i.MX Eukrea Patches for 3.5

----------------------------------------------------------------
Denis Carikli (1):
      ARM: imx: eukrea_mbimxsd: add backlight and lcd support

Eric B?nard (11):
      ARM: imx: eukrea_cpuimx25: enable workaround ENGcm09152
      ARM: imx: eukrea_mbimxsd25: add spi controler and spidev support
      ARM: imx: eukrea_cpuimx25: add watchdog support
      ARM: imx: eukrea_mbimxsd35: add spi controler and spidev support
      ARM: imx: eukrea-cpuimx51: remove board
      ARM: imx: eukrea_cpuimx51sd: add watchdog support
      ARM: imx: eukrea_mbimxsd: add audio support
      ARM: imx: eukrea_cpuimx51sd: support rev2 PCB
      ARM: imx: eukrea_mbimxsd25: don't free twice GPIO_SWITCH1
      ARM: imx: eukrea_mbimxsd25: use IMX_GPIO_NR
      ARM: imx: eukrea_mbimxsd rename to eukrea_mbimxsd51

 arch/arm/mach-imx/Kconfig                          |   35 +--
 arch/arm/mach-imx/Makefile                         |    4 +-
 arch/arm/mach-imx/eukrea_mbimx51-baseboard.c       |  206 --------------
 arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c     |   51 +++-
 arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c     |   42 +++
 ...sd-baseboard.c => eukrea_mbimxsd51-baseboard.c} |  120 ++++++--
 arch/arm/mach-imx/mach-cpuimx51.c                  |  301 --------------------
 arch/arm/mach-imx/mach-cpuimx51sd.c                |   50 +++-
 arch/arm/mach-imx/mach-eukrea_cpuimx25.c           |    2 +
 9 files changed, 241 insertions(+), 570 deletions(-)
 delete mode 100644 arch/arm/mach-imx/eukrea_mbimx51-baseboard.c
 rename arch/arm/mach-imx/{eukrea_mbimxsd-baseboard.c => eukrea_mbimxsd51-baseboard.c} (51%)
 delete mode 100644 arch/arm/mach-imx/mach-cpuimx51.c
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
