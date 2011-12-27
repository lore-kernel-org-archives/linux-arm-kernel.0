From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 27 Dec 2011 18:42:14 +0900
Subject: [GIT PULL] Samsung devel-mmc-spi for v3.3
Message-ID: <000801ccc47b$d474fd00$7d5ef700$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

Please pull the Samsung-devel-mmc-spi for v3.3.
It depends on Samsung-cleanup-spi4 branch as well.

If any problems, please let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit 7d38af51d587ad953eef786a6922bcd1482cae5c:

  ARM: S3C64XX: Modified according to SPI consolidation work (2011-12-23
10:50:03 +0900)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
next-samsung-devel-mmc-spi5

Padmavathi Venna (1):
      ARM: EXYNOS: Modified files for SPI consolidation work

Rajeshwari Shinde (3):
      ARM: S5P64X0: Add HSMMC setup for host Controller
      ARM: S5P64X0: Add lookup of sdhci-s3c clocks using generic names
      ARM: S5P64X0: Enable SDHCI support

 arch/arm/mach-exynos/Kconfig                   |    5 +
 arch/arm/mach-exynos/Makefile                  |    1 +
 arch/arm/mach-exynos/clock.c                   |   73 ++++++++++-------
 arch/arm/mach-exynos/include/mach/irqs.h       |    3 +
 arch/arm/mach-exynos/include/mach/map.h        |    7 ++
 arch/arm/mach-exynos/include/mach/spi-clocks.h |   16 ++++
 arch/arm/mach-exynos/setup-spi.c               |   72 ++++++++++++++++
 arch/arm/mach-s5p64x0/Kconfig                  |   24 ++++++
 arch/arm/mach-s5p64x0/Makefile                 |    1 +
 arch/arm/mach-s5p64x0/clock-s5p6440.c          |   72 ++++++++++-------
 arch/arm/mach-s5p64x0/clock-s5p6450.c          |   72 ++++++++++-------
 arch/arm/mach-s5p64x0/cpu.c                    |    9 ++
 arch/arm/mach-s5p64x0/mach-smdk6440.c          |   25 ++++++
 arch/arm/mach-s5p64x0/mach-smdk6450.c          |   26 ++++++-
 arch/arm/mach-s5p64x0/setup-sdhci-gpio.c       |  104
++++++++++++++++++++++++
 arch/arm/plat-samsung/include/plat/sdhci.h     |   44 ++++++++++
 16 files changed, 463 insertions(+), 91 deletions(-)
 create mode 100644 arch/arm/mach-exynos/include/mach/spi-clocks.h
 create mode 100644 arch/arm/mach-exynos/setup-spi.c
 create mode 100644 arch/arm/mach-s5p64x0/setup-sdhci-gpio.c
