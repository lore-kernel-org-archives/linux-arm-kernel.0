From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Fri, 14 Feb 2014 19:07:09 +0530
Subject: [PATCH v3 0/3] exynos: arch: add support for exynos5260 SoC
Message-ID: <1392385032-22015-1-git-send-email-rahul.sharma@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rahul Sharma <Rahul.Sharma@samsung.com>

V3:
  1) Addressed review comments from Tomasz figa.

V2:
  1) Split up DT patch into SoC and Board patch.

This series is dependent on Sachin's patch
"ARM: EXYNOS: Consolidate CPU init code" at
http://comments.gmane.org/gmane.linux.kernel.samsung-soc/26560

This series is based on Kukjin's for-next branch at
http://git.kernel.org/?p=linux/kernel/git/kgene/linux-samsung.git

Pankaj Dubey (1):
  ARM: EXYNOS: initial board support for exynos5260 SoC

Rahul Sharma (2):
  ARM: dts: add dts files for exynos5260 SoC
  ARM: dts: add dts files for xyref5260 board

 arch/arm/boot/dts/Makefile                      |    1 +
 arch/arm/boot/dts/exynos5260-pinctrl.dtsi       |  574 +++++++++++++++++++++++
 arch/arm/boot/dts/exynos5260-xyref5260-evt0.dts |  105 +++++
 arch/arm/boot/dts/exynos5260.dtsi               |  304 ++++++++++++
 arch/arm/mach-exynos/Kconfig                    |    9 +
 arch/arm/mach-exynos/common.c                   |   11 +
 arch/arm/mach-exynos/include/mach/map.h         |    1 +
 arch/arm/mach-exynos/mach-exynos5-dt.c          |    1 +
 arch/arm/plat-samsung/include/plat/cpu.h        |    8 +
 9 files changed, 1014 insertions(+)
 create mode 100644 arch/arm/boot/dts/exynos5260-pinctrl.dtsi
 create mode 100644 arch/arm/boot/dts/exynos5260-xyref5260-evt0.dts
 create mode 100644 arch/arm/boot/dts/exynos5260.dtsi

-- 
1.7.9.5
