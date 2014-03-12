From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Wed, 12 Mar 2014 20:46:31 +0530
Subject: [PATCH v5 0/3] exynos: arch: add support for exynos5260 SoC
Message-ID: <1394637394-3960-1-git-send-email-rahul.sharma@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rahul Sharma <Rahul.Sharma@samsung.com>

V5:
  1) Removed SYSRAM related code.
  2) Fixed mct clocks.
  3) Add SoC and Board specifc fixed-rate clocks in respective files.

V4:
  1) Removed duplicate MMC Soc property from Board file.

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
 arch/arm/boot/dts/exynos5260-xyref5260-evt0.dts |  110 +++++
 arch/arm/boot/dts/exynos5260.dtsi               |  400 ++++++++++++++++
 arch/arm/mach-exynos/Kconfig                    |    4 +
 arch/arm/mach-exynos/mach-exynos5-dt.c          |    1 +
 6 files changed, 1090 insertions(+)
 create mode 100644 arch/arm/boot/dts/exynos5260-pinctrl.dtsi
 create mode 100644 arch/arm/boot/dts/exynos5260-xyref5260-evt0.dts
 create mode 100644 arch/arm/boot/dts/exynos5260.dtsi

-- 
1.7.9.5
