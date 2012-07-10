From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 10 Jul 2012 11:20:49 +0900
Subject: [GIT PULL] Samsung board-1 for v3.6
Message-ID: <0c5101cd5e42$9f7415d0$de5c4170$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof

Please pull Samsung boards update for v3.6.

If any problems, please let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit cfaf025112d3856637ff34a767ef785ef5cf2ca9:

  Linux 3.5-rc2 (2012-06-08 18:40:09 -0700)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
next/board-samsung

Dimitris Papastamos (1):
      ARM: S3C64XX: Add IRQ mapping for wm0010 on Cragganmore

Mark Brown (4):
      ARM: S3C64XX: Add module identification for Balblair Cragganmore
module
      ARM: S3C64XX: Add WM5102 EVM to Cragganmore modules
      ARM: S3C64XX: Dynamically allocate the IRQ range for WM8994 on
Cragganmore
      ARM: S3C64XX: Dynamically assign interrupts for CPU PMIC on
Cragganmore

Sachin Kamat (4):
      ARM: EXYNOS: Add HSOTG support to Origen
      ARM: EXYNOS: Add HSOTG support to SMDKV310
      ARM: EXYNOS: Update keypad entries for SMDK4X12
      ARM: S5PV210: Add HSOTG support to SMDKV210

 arch/arm/mach-exynos/Kconfig                  |    2 ++
 arch/arm/mach-exynos/mach-origen.c            |    6 ++++++
 arch/arm/mach-exynos/mach-smdk4x12.c          |   10 ++++++----
 arch/arm/mach-exynos/mach-smdkv310.c          |    6 ++++++
 arch/arm/mach-s3c64xx/include/mach/crag6410.h |    4 +---
 arch/arm/mach-s3c64xx/mach-crag6410-module.c  |   10 +++++++++-
 arch/arm/mach-s3c64xx/mach-crag6410.c         |    1 -
 arch/arm/mach-s5pv210/Kconfig                 |    2 ++
 arch/arm/mach-s5pv210/mach-smdkv210.c         |    9 +++++++++
 9 files changed, 41 insertions(+), 9 deletions(-)
