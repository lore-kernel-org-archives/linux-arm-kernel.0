From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 24 Dec 2011 09:58:04 +0900
Subject: [GIT PULL] Samsung devel-spi for v3.3
Message-ID: <087f01ccc1d7$17d4c050$477e40f0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

Please pull the samsung-devel-spi for v3.3.
Same as cleanup-mmc pull requesting, it depends on next-samsung-cleanup-mmc2
branch.

As a note, the number at the end of branch name means the ordering :)
If any problems, please let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit 4346b6d9c6651121f35ae9e42f240f36a8e56ce6:

  mmc: sdhci-s3c: Use generic clock names for sdhci bus clock options
(2011-12-23 10:09:22 +0900)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
next-samsung-devel-spi3

Padmavathi Venna (6):
      spi/s3c64xx: Use bus clocks created using clkdev
      ARM: S3C64XX: Add SPI clkdev support
      ARM: S5PC100: Add SPI clkdev support
      ARM: S5P64X0: Add SPI clkdev support
      ARM: S5PV210: Add SPI clkdev support
      ARM: SAMSUNG: Remove SPI bus clocks from platform data

 arch/arm/mach-s3c64xx/clock.c                    |   80 +++++++++------
 arch/arm/mach-s3c64xx/dev-spi.c                  |    7 --
 arch/arm/mach-s5p64x0/clock-s5p6440.c            |   61 +++++------
 arch/arm/mach-s5p64x0/clock-s5p6450.c            |   49 +++++----
 arch/arm/mach-s5p64x0/dev-spi.c                  |    6 -
 arch/arm/mach-s5pc100/clock.c                    |  124
+++++++++++++---------
 arch/arm/mach-s5pc100/dev-spi.c                  |    7 --
 arch/arm/mach-s5pv210/clock.c                    |   50 +++++----
 arch/arm/mach-s5pv210/dev-spi.c                  |    6 -
 arch/arm/plat-samsung/include/plat/s3c64xx-spi.h |    2 -
 drivers/spi/spi-s3c64xx.c                        |   14 +--
 11 files changed, 215 insertions(+), 191 deletions(-)
