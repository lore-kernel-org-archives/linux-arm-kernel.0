From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 3 Mar 2011 14:57:11 +0000
Subject: [PATCH 0/7] Various Samsung updates
Message-ID: <20110303145710.GA32234@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a patch series I've got built up for the Samsung platforms, some
of which has been pending for the entire release cycle.  I know Ben's
said he's extremely busy right now (as you can see some of these patches
are from him), perhaps it would make sense to apply these via Kukjin's
tree for the time being?

Ben Dooks (2):
      ARM: S3C64XX: Add clock for i2c1
      ARM: S3C64XX: Reduce output of s3c64xx_dma_init1()

Mark Brown (5):
      ARM: SAMSUNG: Include devs.h in dev-uart.c to prototype devices
      ARM: S3C64XX: Staticise non-exported GPIO to interrupt functions
      ARM: S3C64XX: Tone down SDHCI debugging
      ARM: SMDK6410: Fix build with WM1190 disabled and WM1192 enabled
      ARM: SMDK6410: Update regulator names for debugfs compatiblity

 arch/arm/mach-s3c64xx/clock.c         |    6 ++++++
 arch/arm/mach-s3c64xx/dma.c           |   11 ++++++-----
 arch/arm/mach-s3c64xx/gpiolib.c       |    4 ++--
 arch/arm/mach-s3c64xx/mach-smdk6410.c |   13 +++++++------
 arch/arm/mach-s3c64xx/setup-sdhci.c   |    2 +-
 arch/arm/plat-samsung/dev-uart.c      |    2 ++
 6 files changed, 24 insertions(+), 14 deletions(-)
