From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 18 Sep 2010 10:47:19 +0900
Subject: [GIT PULL] Samsung fixes for 2.6.36-rc5
Message-ID: <006001cb56d3$71a63fc0$54f2bf40$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull Samsung fixes from:

git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
s5p-fixes-for-linus

These things are for bug fix on 2.6.36-rc5.
If any problems, please let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.


The following changes since commit 49553c2ef88749dd502687f4eb9c258bb10a4f44:

  Linux 2.6.36-rc4 (2010-09-12 16:07:37 -0700)

are available in the git repository at:
   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
s5p-fixes-for-linus

Darius Augulis (2):
      ARM: S3C64XX: Fix coding style errors on mach-real6410
      ARM: S3C64XX: Add IORESOURCE_IRQ_HIGHLEVEL flag to dm9000 on
mach-real6410

Kukjin Kim (2):
      ARM: SAMSUNG: Fix on drive strength value
      ARM: SAMSUNG: Fix on s5p_gpio_[get,set]_drvstr

Kyungmin Park (1):
      ARM: S5PV210: Reduce the iodesc length of systimer

Marek Szyprowski (2):
      ARM: S5P: Fix DMA coherent mask for FIMC
      ARM: S5PV210: Add FIMC clocks

Mark Brown (2):
      ARM: S3C64XX: Fix dev-spi build
      ARM: S3C64XX: Prototype SPI devices

MyungJoo Ham (1):
      ARM: S5PV210: Update I2C-1 Clock Register Property.

Sylwester Nawrocki (1):
      ARM: S5P: Decrease IO Registers memory region size on FIMC

 arch/arm/mach-s3c64xx/dev-spi.c               |    3 +-
 arch/arm/mach-s3c64xx/mach-real6410.c         |  104
++++++++++++------------
 arch/arm/mach-s5pv210/clock.c                 |   20 +++++-
 arch/arm/mach-s5pv210/cpu.c                   |    2 +-
 arch/arm/plat-s5p/dev-fimc0.c                 |    9 ++-
 arch/arm/plat-s5p/dev-fimc1.c                 |    9 ++-
 arch/arm/plat-s5p/dev-fimc2.c                 |    9 ++-
 arch/arm/plat-samsung/gpio-config.c           |    7 +-
 arch/arm/plat-samsung/include/plat/gpio-cfg.h |   10 +-
 9 files changed, 107 insertions(+), 66 deletions(-)
