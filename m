From: kgene@kernel.org (Kukjin Kim)
Date: Fri, 14 Aug 2015 03:50:30 +0900
Subject: [GIT PULL v2 2/5] Samsung 2nd DT updates for v4.3
In-Reply-To: <55CCE517.2070003@kernel.org>
References: <55CCE517.2070003@kernel.org>
Message-ID: <55CCE6F6.1090001@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 5e080b078fa1f929d9aa5586985d5e7c0739d207:

  ARM: dts: Extend exynos5420-pinctrl nodes using labels instead of
paths (2015-07-21 13:01:23 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
tags/samsung-late-dt

for you to fetch changes up to ba032795463bfc461937dbde7a345103a47f969b:

  ARM: dts: add iommu property to JPEG device for exynos4 (2015-08-14
02:30:58 +0900)

----------------------------------------------------------------
Samsung 2nd DT updates for v4.3

- for exynos3250, 4212, 4412 and 5250
  : add CPU OPP and regulator supply property

- for exynos3250
  : add CPU cooling binding for exynos3250 boards

- for exynos4 SoCs
  : add iommu property to JPEG device

- for exynos4412-odroidu3
  : enable SPI1

- for exynos5250-snow
  : add SPI CS

- for exynos5422
  : add exynos5422-cpus.dtsi to correct cpu order

* Note this branch is depending on tags/samsung-clk-driver

----------------------------------------------------------------
Alexis Ballier (1):
      ARM: dts: enable SPI1 for exynos4412-odroidu3

Bartlomiej Zolnierkiewicz (1):
      ARM: dts: add CPU OPP and regulator supply property for exynos4x12

Chanho Park (1):
      ARM: dts: add exynos5422-cpus.dtsi to correct cpu order

Chanwoo Choi (2):
      ARM: dts: Add CPU OPP and regulator supply property for exynos3250
      ARM: dts: Add CPU cooling binding for exynos3250 boards

Marek Szyprowski (1):
      ARM: dts: add iommu property to JPEG device for exynos4

Michal Suchanek (1):
      ARM: dts: Add SPI CS on exynos5250-snow

Thomas Abraham (1):
      ARM: dts: add CPU OPP and regulator supply property for exynos5250

 arch/arm/boot/dts/exynos3250-monk.dts              | 19 +++++
 arch/arm/boot/dts/exynos3250-rinato.dts            | 19 +++++
 arch/arm/boot/dts/exynos3250.dtsi                  | 16 +++++
 arch/arm/boot/dts/exynos4.dtsi                     |  1 +
 arch/arm/boot/dts/exynos4212.dtsi                  | 81
+++++++++++++++++++++
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi    |  4 ++
 arch/arm/boot/dts/exynos4412-odroidu3.dts          |  8 +++
 arch/arm/boot/dts/exynos4412-origen.dts            |  4 ++
 arch/arm/boot/dts/exynos4412-trats2.dts            |  4 ++
 arch/arm/boot/dts/exynos4412.dtsi                  | 83
++++++++++++++++++++++
 arch/arm/boot/dts/exynos5250-arndale.dts           |  4 ++
 arch/arm/boot/dts/exynos5250-smdk5250.dts          |  4 ++
 arch/arm/boot/dts/exynos5250-snow.dts              |  5 ++
 arch/arm/boot/dts/exynos5250-spring.dts            |  4 ++
 arch/arm/boot/dts/exynos5250.dtsi                  | 22 ++++++
 arch/arm/boot/dts/exynos5422-cpus.dtsi             | 81
+++++++++++++++++++++
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |  1 +
 17 files changed, 360 insertions(+)
 create mode 100644 arch/arm/boot/dts/exynos5422-cpus.dtsi
