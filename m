From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 31 Jan 2012 15:10:37 +0900
Subject: [GIT PULL] Samsung fixes-2 for v3.3
Message-ID: <041f01ccdfdf$0cb76b70$26264250$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please pull 2nd Samsung fixes for v3.3, from following:
  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git v3.3-samsung-fixes-2

If any problems, please kindly let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit dcd6c92267155e70a94b3927bce681ce74b80d1f:

  Linux 3.3-rc1 (2012-01-19 15:04:48 -0800)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git v3.3-samsung-fixes-2

Heiko Stuebner (1):
      ARM: SAMSUNG: Fix missing api-change from subsys_interface change

Jonghwan Choi (1):
      ARM: EXYNOS: Fix "warning: initialization from incompatible pointer type"

Kukjin Kim (2):
      ARM: EXYNOS: Remove build warning without enabling PM
      ARM: S5PV210: Fix the name of exynos4_clk_hdmiphy_ctrl() for S5PV210

Marek Szyprowski (1):
      ARM: EXYNOS: fix non-SMP builds for EXYNOS4

Mark Brown (2):
      ARM: S3C64XX: Make s3c64xx_init_uarts() static
      ARM: S3C6410: Use device names for both I2C clocks

Sylwester Nawrocki (3):
      ARM: SAMSUNG: Fix platform data setup for I2C adapter 0
      ARM: EXYNOS: Correct framebuffer window size on Nuri board
      ARM: EXYNOS: Correct M-5MOLS sensor clock frequency on Universal C210 board

 arch/arm/mach-exynos/clock-exynos4210.c      |    2 ++
 arch/arm/mach-exynos/clock-exynos4212.c      |    2 ++
 arch/arm/mach-exynos/clock.c                 |    2 ++
 arch/arm/mach-exynos/mach-nuri.c             |    8 ++++----
 arch/arm/mach-exynos/mach-universal_c210.c   |    2 +-
 arch/arm/mach-exynos/pm.c                    |    4 +++-
 arch/arm/mach-s3c2410/cpu-freq.c             |    8 +++++---
 arch/arm/mach-s3c2410/dma.c                  |    5 +++--
 arch/arm/mach-s3c2410/pll.c                  |    2 +-
 arch/arm/mach-s3c2410/pm.c                   |    2 +-
 arch/arm/mach-s3c2412/cpu-freq.c             |    3 ++-
 arch/arm/mach-s3c2412/dma.c                  |    3 ++-
 arch/arm/mach-s3c2412/irq.c                  |    2 +-
 arch/arm/mach-s3c2412/pm.c                   |    2 +-
 arch/arm/mach-s3c2416/irq.c                  |    3 ++-
 arch/arm/mach-s3c2416/pm.c                   |    2 +-
 arch/arm/mach-s3c2440/clock.c                |    2 +-
 arch/arm/mach-s3c2440/dma.c                  |    3 ++-
 arch/arm/mach-s3c2440/irq.c                  |    2 +-
 arch/arm/mach-s3c2440/s3c2440-cpufreq.c      |    3 ++-
 arch/arm/mach-s3c2440/s3c2440-pll-12000000.c |    2 +-
 arch/arm/mach-s3c2440/s3c2440-pll-16934400.c |    3 ++-
 arch/arm/mach-s3c2440/s3c2442.c              |    2 +-
 arch/arm/mach-s3c2440/s3c244x-clock.c        |    2 +-
 arch/arm/mach-s3c2440/s3c244x-irq.c          |    2 +-
 arch/arm/mach-s3c2443/dma.c                  |    3 ++-
 arch/arm/mach-s3c2443/irq.c                  |    3 ++-
 arch/arm/mach-s3c64xx/clock.c                |    5 +++++
 arch/arm/mach-s3c64xx/common.c               |    2 +-
 arch/arm/mach-s5p64x0/pm.c                   |    2 +-
 arch/arm/mach-s5pv210/clock.c                |    4 ++--
 arch/arm/mach-s5pv210/pm.c                   |    2 +-
 arch/arm/plat-samsung/devs.c                 |    4 +++-
 33 files changed, 62 insertions(+), 36 deletions(-)
