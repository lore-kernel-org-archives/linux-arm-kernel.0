From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 26 Sep 2014 01:55:44 +0900
Subject: [GIT PULL 2/3] 3rd Round of Samsung-DT-3 updates for v3.18
Message-ID: <54244910.3050609@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 57901371c9914d5e5eeabf2870c35162837198d2:

   ARM: dts: add MFC codec device node for exynos3250 (2014-09-24 
01:33:23 +0900)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
tags/samsung-dt-3

for you to fetch changes up to 0d2ff37147727b62d99d250076e6f849a38a72ef:

   ARM: dts: add CPU nodes for Exynos4 SoCs (2014-09-25 17:40:14 +0900)

----------------------------------------------------------------
Samsung 3rd DT updates for v3.18

- Fix rebase conflcits in previous tags/samsung-dt-2
   : Fix chip select GPIO for exynos5250-smdk5250
   : Remove display timings node for exynos5250-snow

- Fix Exynos USB on kernels with USB Gadget support
   : Explicitly set dr_mode for the dwc3 controller
   for exynos5420-arndale-octa, exynos5420-peach-pit
   and exynos5800-peach-pi boards

- add CPU nodes for exynos4210, exynos4212, exynos4412

----------------------------------------------------------------
Bartlomiej Zolnierkiewicz (1):
       ARM: dts: add CPU nodes for Exynos4 SoCs

Javier Martinez Canillas (2):
       ARM: dts: Fix chip select GPIO on exynos5250-smdk5250
       ARM: dts: Remove display timings node from exynos5250-snow

Sjoerd Simons (2):
       ARM: dts: Explicitly set dr_mode on exynos Peach boards
       ARM: dts: Explicitly set dr_mode on exynos5420-arndale-octa

  arch/arm/boot/dts/exynos4210.dtsi             | 17 ++++++++++++++++
  arch/arm/boot/dts/exynos4212.dtsi             | 17 ++++++++++++++++
  arch/arm/boot/dts/exynos4412.dtsi             | 29 
+++++++++++++++++++++++++++
  arch/arm/boot/dts/exynos5250-smdk5250.dts     |  2 +-
  arch/arm/boot/dts/exynos5250-snow.dts         | 16 ---------------
  arch/arm/boot/dts/exynos5420-arndale-octa.dts |  4 ++++
  arch/arm/boot/dts/exynos5420-peach-pit.dts    |  8 ++++++++
  arch/arm/boot/dts/exynos5420.dtsi             |  4 ++--
  arch/arm/boot/dts/exynos5800-peach-pi.dts     |  8 ++++++++
  9 files changed, 86 insertions(+), 19 deletions(-)
