From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 27 May 2014 07:13:02 +0900
Subject: [GIT PULL 4th 2/2] Samsung Exynos 2nd SoC updates for 3.16
Message-ID: <5383BC6E.1020101@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 43baa7dcb5fa0c95b1e443d2a739c14de1fbbe07:

   cpufreq: exynos: Fix driver compilation with ARCH_MULTIPLATFORM 
(2014-05-27 06:22:53 +0900)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
tags/exynos-soc-2

for you to fetch changes up to 127cd84d7d1b7e50f5f3e728da23e6f8ac89d249:

   ARM: dts: Add initial device tree support for EXYNOS5410 (2014-05-27 
06:54:13 +0900)

----------------------------------------------------------------
Exynos 2nd new SoC support for 3.16

- add support for exynos5410 SoC and exynos5410-smdk5410 board

----------------------------------------------------------------
Tarek Dakhran (3):
       ARM: EXYNOS: Add support for EXYNOS5410 SoC
       clk: exynos5410: register clocks using common clock framework
       ARM: dts: Add initial device tree support for EXYNOS5410

  .../devicetree/bindings/clock/exynos5410-clock.txt |  45 +++++
  arch/arm/boot/dts/Makefile                         |   1 +
  arch/arm/boot/dts/exynos5410-smdk5410.dts          |  82 ++++++++
  arch/arm/boot/dts/exynos5410.dtsi                  | 206 
++++++++++++++++++++
  arch/arm/mach-exynos/Kconfig                       |   5 +
  arch/arm/mach-exynos/common.h                      |  12 +-
  drivers/clk/samsung/Makefile                       |   1 +
  drivers/clk/samsung/clk-exynos5410.c               | 209 
+++++++++++++++++++++
  include/dt-bindings/clock/exynos5410.h             |  33 ++++
  9 files changed, 592 insertions(+), 2 deletions(-)
  create mode 100644 
Documentation/devicetree/bindings/clock/exynos5410-clock.txt
  create mode 100644 arch/arm/boot/dts/exynos5410-smdk5410.dts
  create mode 100644 arch/arm/boot/dts/exynos5410.dtsi
  create mode 100644 drivers/clk/samsung/clk-exynos5410.c
  create mode 100644 include/dt-bindings/clock/exynos5410.h
