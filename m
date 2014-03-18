From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 18 Mar 2014 13:27:56 +0900
Subject: [GIT PULL] Samsung non-critical fixes for v3.15
Message-ID: <5327CB4C.9070905@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 38dbfb59d1175ef458d006556061adeaa8751b72:

   Linus 3.14-rc1 (2014-02-02 16:42:13 -0800)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
tags/samsung-fixes

for you to fetch changes up to baf64abc468c7583592f67197ae23fa31414b4db:

   ARM: S3C64XX: mach-crag6410-module.c is not modular (2014-02-16 
02:05:44 +0900)

----------------------------------------------------------------
Samsung non-critical fixes for v3.15
- fix typo CONFIG_CPU_S3C2443 in Kconfig
- fix G3D regulator on because of entering low power mode
   for exynos5250-arndale
- fix CONFIG_USB_EHCI_EXYNOS for exynos_defconfig
- fix initcall of mach-crag6410-module.c

----------------------------------------------------------------
Paul Bolle (1):
       ARM: S3C24XX: Fix typo CONFIG_CPUS_3C2443

Paul Gortmaker (1):
       ARM: S3C64XX: mach-crag6410-module.c is not modular

Tomasz Figa (1):
       ARM: dts: Keep G3D regulator always on for exynos5250-arndale

Tushar Behera (1):
       ARM: exynos_defconfig: Update EHCI config entry

  arch/arm/boot/dts/exynos5250-arndale.dts     | 1 +
  arch/arm/configs/exynos_defconfig            | 2 +-
  arch/arm/mach-s3c24xx/common.c               | 2 +-
  arch/arm/mach-s3c64xx/mach-crag6410-module.c | 2 +-
  4 files changed, 4 insertions(+), 3 deletions(-)
