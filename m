From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 20 Jul 2012 07:42:37 +0900
Subject: [GIT PULL] Samsung board-3 for v3.6
Message-ID: <195101cd65ff$cc0a8600$641f9200$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof

Please pull 3rd updates for samsung stuff v3.6 from:
  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git next/board-samsung-3

It is including several changes for samsung boards.

If any problems, please kindly let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit 23c7301d74ac2d80d0dafd6f84a6d11a0fc15ce5:

  Merge branch 'next/board-samsung-2' into next/board-samsung-3 (2012-07-19 14:29:30 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git next/board-samsung-3

Kukjin Kim (1):
      ARM: SAMSUNG: no need to set the value for clk_xusbxti when it is 24Mhz

Mark Brown (2):
      ARM: S3C64XX: Clean up after SPI driver platform data updates
      ARM: S3C64XX: Mark most Cragganmore initdata devinitdata

Ricardo Salveti de Araujo (1):
      ARM: EXYNOS: Add leds status1 and status2 on Origen board

Sachin Kamat (2):
      ARM: EXYNOS: Add DRM device to SMDK4X12 board
      ARM: EXYNOS: Add missing .reserve field to SMDKC210

 arch/arm/mach-exynos/Kconfig                 |    1 +
 arch/arm/mach-exynos/mach-nuri.c             |    3 +-
 arch/arm/mach-exynos/mach-origen.c           |   33 ++++++++++++-
 arch/arm/mach-exynos/mach-smdk4x12.c         |   32 +++++++++++-
 arch/arm/mach-exynos/mach-smdkv310.c         |    4 +-
 arch/arm/mach-exynos/mach-universal_c210.c   |    3 +-
 arch/arm/mach-s3c64xx/mach-crag6410-module.c |    1 -
 arch/arm/mach-s3c64xx/mach-crag6410.c        |   68 +++++++++++++-------------
 arch/arm/mach-s5pv210/mach-goni.c            |    4 +-
 arch/arm/mach-s5pv210/mach-smdkv210.c        |    3 +-
 10 files changed, 102 insertions(+), 50 deletions(-)
