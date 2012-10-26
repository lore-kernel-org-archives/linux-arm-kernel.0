From: amit.daniel@samsung.com (Amit Daniel Kachhap)
Date: Fri, 26 Oct 2012 14:59:04 +0530
Subject: [PATCH v2 0/2] ARM: exynos: Enable TMU support in exynos platforms
Message-ID: <1351243746-4173-1-git-send-email-amit.daniel@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Amit Daniel Kachhap <amit.daniel@samsung.com>

These TMU enablement patches are needed for exynos4 and exynos5 TMU
driver already merged(drivers/thermal/exynos_thermal.c).

This patchset is based on Samsung Maintainer's tree,
git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git for-next

Amit Daniel Kachhap (2):
  ARM: exynos4: Add devicetree node for TMU driver
  ARM: exynos5: Add devicetree node for TMU driver

 arch/arm/boot/dts/exynos4210.dtsi        |    7 +++++++
 arch/arm/boot/dts/exynos5250.dtsi        |    6 ++++++
 arch/arm/mach-exynos/clock-exynos4.c     |    4 ++++
 arch/arm/mach-exynos/clock-exynos5.c     |    5 +++++
 arch/arm/mach-exynos/include/mach/irqs.h |    3 +++
 arch/arm/mach-exynos/include/mach/map.h  |    3 +++
 arch/arm/mach-exynos/mach-exynos4-dt.c   |    2 ++
 arch/arm/mach-exynos/mach-exynos5-dt.c   |    2 ++
 8 files changed, 32 insertions(+), 0 deletions(-)
