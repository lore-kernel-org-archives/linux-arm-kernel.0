From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 3 Jan 2012 09:54:33 +0100
Subject: [GIT PULL] i.MX assorted
Message-ID: <20120103085433.GJ5446@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd Olof,

Please pull the following assorted i.MX feature patches.

Sascha

The following changes since commit 384703b8e6cd4c8ef08512e596024e028c91c339:

  Linux 3.2-rc6 (2011-12-16 18:36:26 -0800)

are available in the git repository at:
  git://git.pengutronix.de/git/imx/linux-2.6.git imx-features-assorted

Fabio Estevam (1):
      ARM: mx31pdk: Add MC13783 RTC support

Gwenhael Goavec-Merou (1):
      MX1:apf9328: Add i2c support

Jaccon Bastiaansen (1):
      Enable 32 bit flash support for iMX21ADS board

Paul Fertser (1):
      iomux-mx25: configuration to support CSPI3 on CSI pins

 arch/arm/configs/imx_v4_v5_defconfig        |    1 -
 arch/arm/mach-imx/Kconfig                   |    1 +
 arch/arm/mach-imx/mach-apf9328.c            |   10 ++++++++++
 arch/arm/mach-imx/mach-mx31_3ds.c           |    2 +-
 arch/arm/plat-mxc/include/mach/iomux-mx25.h |    4 ++++
 5 files changed, 16 insertions(+), 2 deletions(-)
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
