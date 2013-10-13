From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 14 Oct 2013 06:56:50 +0900
Subject: [GIT PULL] Samsung fixes-1 for v3.12
Message-ID: <525B1722.5060001@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 272b98c6455f00884f0350f775c5342358ebb73f:

   Linux 3.12-rc1 (2013-09-16 16:17:51 -0400)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
tags/samsung-fixes-1

for you to fetch changes up to b7f8c479e112cc09422aac2bda923a86b381fcc0:

   ARM: dts: fix PL330 MDMA1 address in DT for Universal C210 board 
(2013-10-08 07:09:52 +0900)

----------------------------------------------------------------
Fixes for v3.12
- fix UART for switching FIFO
- correct typo 'samsung,pin-drv'
- correct typo 'earlyprintk'
- remove DP PHY for supporting dptx-phy on exynos5250
- cpufreq regulator lookup for exynos4210-origen and trats
- fix PL330 MDMA1 address for universal c210 board

----------------------------------------------------------------
Al Stone (1):
       ARM: dts: Correct typo in use of samsung,pin-drv for exynos5250

Alexander Shiyan (1):
       ARM: SAMSUNG: Fix switching FIFO in arch_enable_uart_fifo function

Bartlomiej Zolnierkiewicz (1):
       ARM: dts: fix PL330 MDMA1 address in DT for Universal C210 board

Jingoo Han (1):
       ARM: dts: Remove DP PHY node from exynos5250.dtsi

Tomasz Figa (1):
       ARM: dts: Work around lack of cpufreq regulator lookup for 
exynos4210-origen and trats boards

Youngmin Nam (1):
       ARM: dts: Fix a typo on Exynos5440 DTS files

  arch/arm/boot/dts/exynos4210-origen.dts         |  7 +++-
  arch/arm/boot/dts/exynos4210-trats.dts          |  7 +++-
  arch/arm/boot/dts/exynos4210-universal_c210.dts |  4 +++
  arch/arm/boot/dts/exynos5250-pinctrl.dtsi       | 44 
++++++++++++-------------
  arch/arm/boot/dts/exynos5250.dtsi               | 13 +++-----
  arch/arm/boot/dts/exynos5440-sd5v1.dts          |  2 +-
  arch/arm/boot/dts/exynos5440-ssdk5440.dts       |  2 +-
  arch/arm/plat-samsung/include/plat/uncompress.h |  2 ++
  8 files changed, 47 insertions(+), 34 deletions(-)
