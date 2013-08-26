From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 26 Aug 2013 09:14:35 +0900
Subject: [GIT PULL 2/3] 2nd Round Samsung DT for v3.12
Message-ID: <1f7601cea1f1$3f2913d0$bd7b3b70$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 6f9d02a056fff8e965da0f940a09d4c39a4fe80a:

  ARM: dts: Add USB host node for Exynos4 (2013-08-19 05:07:17 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
tags/samsung-dt-2

for you to fetch changes up to f408f9db7deb9ce24b4a8875fdf54483d5068627:

  ARM: dts: add ADC device tree node for exynos5420/5250 (2013-08-26
02:44:30 +0900)

----------------------------------------------------------------
Update exynos DT:
- fix the RTC DT node name for exynos5250
- update the "status" property of RTC DT node for exynos5250
- add RTC DT node for  exynos5420
- add ADC DT node for exynos5420 and exynos5250

Based on previouse exynos DT branch, v3.12-next/dt-exynos

----------------------------------------------------------------
Naveen Krishna Chatradhi (1):
      ARM: dts: add ADC device tree node for exynos5420/5250

Vikas Sajjan (3):
      ARM: dts: Fix the RTC DT node name for Exynos5250
      ARM: dts: Update the "status" property of RTC DT node for Exynos5250
SoC
      ARM: dts: Add RTC DT node to Exynos5420 SoC

 arch/arm/boot/dts/exynos5.dtsi           |    2 +-
 arch/arm/boot/dts/exynos5250-arndale.dts |    4 ----
 arch/arm/boot/dts/exynos5250-snow.dts    |    4 ----
 arch/arm/boot/dts/exynos5250.dtsi        |   14 +++++++++++++-
 arch/arm/boot/dts/exynos5420.dtsi        |   17 +++++++++++++++++
 5 files changed, 31 insertions(+), 10 deletions(-)
