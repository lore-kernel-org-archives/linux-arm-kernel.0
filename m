From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 25 May 2013 08:25:15 +0900
Subject: [GIT PULL] Samsung fixes-3 for v3.10
Message-ID: <519FF6DB.5040002@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit f722406faae2d073cc1d01063d1123c35425939e:

   Linux 3.10-rc1 (2013-05-11 17:14:08 -0700)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
tags/samsung-fixes-3

for you to fetch changes up to 15f504f0c2038b9a0f1569c9ce34def61f0c65be:

   ARM: SAMSUNG: Add names to fimd0 IRQ resources (2013-05-25 06:49:43 
+0900)

----------------------------------------------------------------
Fixes following for v3.10
- to get usb2 working on the Chromebook with adding the
   usb phy node for usb2 on exynos5250
- supporting exynos4210 rev0 SoC
- exynos5440 restart applying only to powered-on domains
- drm-exynos probe failure with adding resource names to
   fimd0 platform device

----------------------------------------------------------------
Jungseok Lee (1):
       ARM: EXYNOS: fix software reset logic for EXYNOS5440 SOC

Tomasz Figa (2):
       ARM: EXYNOS: Fix support of Exynos4210 rev0 SoC
       ARM: SAMSUNG: Add names to fimd0 IRQ resources

Vivek Gautam (1):
       ARM: dts: Enabling samsung-usb2phy driver for exynos5250

  arch/arm/boot/dts/exynos5250.dtsi          | 15 ++++++++++++
  arch/arm/mach-exynos/Kconfig               |  3 ++-
  arch/arm/mach-exynos/common.c              | 39 
++++++++++++++++++++++++++++--
  arch/arm/mach-exynos/common.h              |  2 ++
  arch/arm/mach-exynos/mach-universal_c210.c |  5 ++--
  arch/arm/plat-samsung/devs.c               |  6 ++---
  6 files changed, 61 insertions(+), 9 deletions(-)
The following changes since commit f722406faae2d073cc1d01063d1123c35425939e:

   Linux 3.10-rc1 (2013-05-11 17:14:08 -0700)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
tags/samsung-fixes-3

for you to fetch changes up to 15f504f0c2038b9a0f1569c9ce34def61f0c65be:

   ARM: SAMSUNG: Add names to fimd0 IRQ resources (2013-05-25 06:49:43 
+0900)

----------------------------------------------------------------
Fixes following for v3.10
- to get usb2 working on the Chromebook with adding the
   usb phy node for usb2 on exynos5250
- supporting exynos4210 rev0 SoC
- exynos5440 restart applying only to powered-on domains
- drm-exynos probe failure with adding resource names to
   fimd0 platform device

----------------------------------------------------------------
Jungseok Lee (1):
       ARM: EXYNOS: fix software reset logic for EXYNOS5440 SOC

Tomasz Figa (2):
       ARM: EXYNOS: Fix support of Exynos4210 rev0 SoC
       ARM: SAMSUNG: Add names to fimd0 IRQ resources

Vivek Gautam (1):
       ARM: dts: Enabling samsung-usb2phy driver for exynos5250

  arch/arm/boot/dts/exynos5250.dtsi          | 15 ++++++++++++
  arch/arm/mach-exynos/Kconfig               |  3 ++-
  arch/arm/mach-exynos/common.c              | 39 
++++++++++++++++++++++++++++--
  arch/arm/mach-exynos/common.h              |  2 ++
  arch/arm/mach-exynos/mach-universal_c210.c |  5 ++--
  arch/arm/plat-samsung/devs.c               |  6 ++---
  6 files changed, 61 insertions(+), 9 deletions(-)
