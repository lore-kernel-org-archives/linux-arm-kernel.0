From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 16 Oct 2013 07:30:37 +0900
Subject: [GIT PULL v2] Samsung-fixes for v3.12
Message-ID: <525DC20D.4080302@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 272b98c6455f00884f0350f775c5342358ebb73f:

   Linux 3.12-rc1 (2013-09-16 16:17:51 -0400)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
tags/samsung-fixes-v2

for you to fetch changes up to 22c98592094e6c149b05cc13d4d6ec495e6f5879:

   ARM: dts: fix PL330 MDMA1 address in DT for Universal C210 board 
(2013-10-16 07:25:41 +0900)

----------------------------------------------------------------
Fixes for v3.12
- correct typo 'samsung,pin-drv'
- correct typo 'earlyprintk'
- cpufreq regulator lookup for exynos4210-origen and trats
- fix PL330 MDMA1 address for universal c210 board

----------------------------------------------------------------
Al Stone (1):
       ARM: dts: Correct typo in use of samsung,pin-drv for exynos5250

Bartlomiej Zolnierkiewicz (1):
       ARM: dts: fix PL330 MDMA1 address in DT for Universal C210 board

Tomasz Figa (1):
       ARM: dts: Work around lack of cpufreq regulator lookup for 
exynos4210-origen and trats boards

Youngmin Nam (1):
       ARM: dts: Fix typo earlyprintk in exynos5440-sd5v1 and ssdk5440 
boards

  arch/arm/boot/dts/exynos4210-origen.dts         |  7 +++-
  arch/arm/boot/dts/exynos4210-trats.dts          |  7 +++-
  arch/arm/boot/dts/exynos4210-universal_c210.dts |  4 +++
  arch/arm/boot/dts/exynos5250-pinctrl.dtsi       | 44 
++++++++++++-------------
  arch/arm/boot/dts/exynos5440-sd5v1.dts          |  2 +-
  arch/arm/boot/dts/exynos5440-ssdk5440.dts       |  2 +-
  6 files changed, 40 insertions(+), 26 deletions(-)
