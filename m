From: kgene@kernel.org (Kukjin Kim)
Date: Tue, 04 Aug 2015 16:29:25 +0900
Subject: [GIT PULL 4/5] Samsung 2nd DT updates for v4.3
Message-ID: <55C069D5.1050409@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof, Kevin

This 2nd DT update branch is based tags/samsung-dt-1 +
v4.3-topic/clk-samsung branch because of dependency to support generic
cpufreq driver. Please pull.

Thanks,
Kukjin


The following changes since commit e4a39d904c3c3e4855287b7325306289ff044b06:

  Merge branch 'v4.3-topic/clk-samsung' into v4.3-next/dt-samsung-2
(2015-07-24 12:54:00 +0900)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
tags/samsung-dt-2

for you to fetch changes up to 71ae9acc2e3b4b85a08c65e7f411d110b786ca1d:

  ARM: dts: Add SPI CS on exynos5250-snow (2015-07-30 23:12:43 +0900)

----------------------------------------------------------------
Samsung 2nd DT updates for v4.3

- for exynos3250 and 5250
  : add CPU OPP and regulator supply property
    (note depends on v4.3-topic/clk-samsung)
- for exynos3250
  : add CPU cooling binding for exynos3250 boards
- for exynos5250-snow
  : add SPI CS
- for exynos5422
  : add exynos5422-cpus.dtsi to correct cpu order

----------------------------------------------------------------
Chanho Park (1):
      ARM: dts: add exynos5422-cpus.dtsi to correct cpu order

Chanwoo Choi (2):
      ARM: dts: Add CPU OPP and regulator supply property for exynos3250
      ARM: dts: Add CPU cooling binding for exynos3250 boards

Michal Suchanek (1):
      ARM: dts: Add SPI CS on exynos5250-snow

Thomas Abraham (1):
      ARM: dts: add CPU OPP and regulator supply property for exynos5250

 arch/arm/boot/dts/exynos3250-monk.dts              | 19 +++++
 arch/arm/boot/dts/exynos3250-rinato.dts            | 19 +++++
 arch/arm/boot/dts/exynos3250.dtsi                  | 16 +++++
 arch/arm/boot/dts/exynos5250-arndale.dts           |  4 ++
 arch/arm/boot/dts/exynos5250-smdk5250.dts          |  4 ++
 arch/arm/boot/dts/exynos5250-snow.dts              |  5 ++
 arch/arm/boot/dts/exynos5250-spring.dts            |  4 ++
 arch/arm/boot/dts/exynos5250.dtsi                  | 22 ++++++
 arch/arm/boot/dts/exynos5422-cpus.dtsi             | 81
++++++++++++++++++++++
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |  1 +
 10 files changed, 175 insertions(+)
 create mode 100644 arch/arm/boot/dts/exynos5422-cpus.dtsi
