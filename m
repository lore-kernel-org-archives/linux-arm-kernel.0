From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 13 Oct 2009 10:36:52 +0200
Subject: MXC Pull request for -rc
Message-ID: <20091013083652.GB8818@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Please pull the following patches for -rc.

Sascha

The following changes since commit 17d857be649a21ca90008c6dc425d849fa83db5c:
  Linus Torvalds (1):
        Linux 2.6.32-rc1

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git for-rmk-rc

Guennadi Liakhovetski (2):
      fix compilation of i.MX31 platforms
      fix pcm037_eet compilation with the new SPI driver

Sascha Hauer (6):
      i.MX27 clock: rename spi clocks to match device
      mx25 devices: Add missing include
      mx25pdk: remove nand support as it is not present in current tree
      mx25: Add missing copyright / license header
      pcm038: Add SPI/MC13783 support
      pcm970 mmc: Fix ro switch

Valentin Longchamp (1):
      MXC: fix reset for mx31, mx35 and mx27 SoCs

 arch/arm/mach-mx2/clock_imx27.c      |    8 ++--
 arch/arm/mach-mx2/pcm038.c           |   96 +++++++++++++++++++++++++++++++++-
 arch/arm/mach-mx2/pcm970-baseboard.c |    2 +-
 arch/arm/mach-mx25/devices.c         |   19 +++++++
 arch/arm/mach-mx25/mx25pdk.c         |   25 ++++++---
 arch/arm/mach-mx3/clock-imx35.c      |    2 +-
 arch/arm/mach-mx3/clock.c            |    2 +-
 arch/arm/mach-mx3/devices.c          |   24 ++++----
 arch/arm/mach-mx3/devices.h          |    6 +-
 arch/arm/mach-mx3/mm.c               |    2 +
 10 files changed, 155 insertions(+), 31 deletions(-)

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
