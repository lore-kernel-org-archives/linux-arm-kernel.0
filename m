From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 31 May 2014 04:59:24 +0900
Subject: [GIT PULL 2/5] Samsung DT updates for 3.16
Message-ID: <5388E31C.5070903@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 3c8977f17796f0b8816a1a283b0b80b71c83d416:

   ARM: dts: enable usb nodes for exynos4412-trats2 (2014-05-23 03:31:33 
+0900)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
tags/samsung-dt-3

for you to fetch changes up to 345e9bf08276395bd6620dfab56d1b679136d2ce:

   ARM: dts: add secure firmware support for exynos5420-arndale-octa 
(2014-05-31 04:03:31 +0900)

----------------------------------------------------------------
Samsung 3rd DT updates for v3.16

- add dts files support for new SoCs
   : exynos3250 SoC
   : exynos5260 SoC and exynos5260-xyref5260 board
   : exynos5410 SoC and exynos5410-smdk5410 board
   : exynos5800 SoC and exynos5800-peach-pi board

- exynos4210-origen and exynos4412-origen
   : enable RTC and WDT nodes
   : use key code macros

- exynos5250-arndale
   : use key code macros

- exynos5420-arndale-octa
   : add secure firmware support

- exynos5440
   : update watchdog node name

----------------------------------------------------------------
Arun Kumar K (5):
       ARM: dts: add dts file for exynos5800 SoC
       ARM: dts: add dts file for exynos5800-peach-pi board
       ARM: dts: add mfc node for exynos5800
       ARM: dts: correct the usb phy node in exynos5420-peach-pit
       ARM: dts: correct the usb phy node in exynos5800-peach-pi

Chanwoo Choi (1):
       ARM: dts: add pmu sysreg node to exynos3250

Rahul Sharma (5):
       ARM: dts: add dts files for exynos5260 SoC
       ARM: dts: add dts file for exynos5260-xyref5260 board
       ARM: dts: enable hdmi for exynos5800-peach-pi
       ARM: dts: enable display controller for exynos5800-peach-pi
       ARM: dts: enable fimd for exynos5800-peach-pi

Sachin Kamat (3):
       ARM: dts: enable RTC and WDT nodes on Origen boards
       ARM: dts: use key code macros on Origen and Arndale boards
       ARM: dts: update watchdog node name in exynos5440

Tarek Dakhran (1):
       ARM: dts: add dts files for exynos5410 and exynos5410-smdk5410

Tomasz Figa (1):
       ARM: dts: add dts files for exynos3250 SoC

Tushar Behera (1):
       ARM: dts: add secure firmware support for exynos5420-arndale-octa

Vivek Gautam (1):
       ARM: dts: add Vbus regulator for USB 3.0 on exynos5800-peach-pi

  .../devicetree/bindings/arm/samsung/pmu.txt        |   1 +
  arch/arm/boot/dts/Makefile                         |   5 +-
  arch/arm/boot/dts/exynos3250-pinctrl.dtsi          | 475 +++++++++++++++++
  arch/arm/boot/dts/exynos3250.dtsi                  | 444 ++++++++++++++++
  arch/arm/boot/dts/exynos4210-origen.dts            |  19 +-
  arch/arm/boot/dts/exynos4412-origen.dts            |  21 +-
  arch/arm/boot/dts/exynos5250-arndale.dts           |  13 +-
  arch/arm/boot/dts/exynos5260-pinctrl.dtsi          | 574 
+++++++++++++++++++++
  arch/arm/boot/dts/exynos5260-xyref5260.dts         | 103 ++++
  arch/arm/boot/dts/exynos5260.dtsi                  | 304 +++++++++++
  arch/arm/boot/dts/exynos5410-smdk5410.dts          |  82 +++
  arch/arm/boot/dts/exynos5410.dtsi                  | 206 ++++++++
  arch/arm/boot/dts/exynos5420-arndale-octa.dts      |   5 +
  arch/arm/boot/dts/exynos5420-peach-pit.dts         |   4 +-
  arch/arm/boot/dts/exynos5440.dtsi                  |   2 +-
  arch/arm/boot/dts/exynos5800-peach-pi.dts          | 253 +++++++++
  arch/arm/boot/dts/exynos5800.dtsi                  |  28 +
  17 files changed, 2518 insertions(+), 21 deletions(-)
  create mode 100644 arch/arm/boot/dts/exynos3250-pinctrl.dtsi
  create mode 100644 arch/arm/boot/dts/exynos3250.dtsi
  create mode 100644 arch/arm/boot/dts/exynos5260-pinctrl.dtsi
  create mode 100644 arch/arm/boot/dts/exynos5260-xyref5260.dts
  create mode 100644 arch/arm/boot/dts/exynos5260.dtsi
  create mode 100644 arch/arm/boot/dts/exynos5410-smdk5410.dts
  create mode 100644 arch/arm/boot/dts/exynos5410.dtsi
  create mode 100644 arch/arm/boot/dts/exynos5800-peach-pi.dts
  create mode 100644 arch/arm/boot/dts/exynos5800.dtsi
