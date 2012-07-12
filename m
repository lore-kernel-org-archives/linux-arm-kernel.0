From: amit.daniel@samsung.com (Amit Daniel Kachhap)
Date: Thu, 12 Jul 2012 14:45:41 +0530
Subject: [PATCH 0/2] ARM: exynos: Enable TMU support in exynos platforms
Message-ID: <1342084543-8302-1-git-send-email-amit.daniel@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These TMU enablement patches are needed for exynos4 and exynos5 TMU
driver patches sent earlier. The link for those are 
http://www.spinics.net/lists/lm-sensors/msg35858.html.

Also patch 1 depends on combiner dt node patch sent by Thomas Abraham.
(http://www.spinics.net/lists/arm-kernel/msg184129.html)

This patchset is based Samsung Maintainer's tree,
git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git for-next

Amit Daniel Kachhap (2):
  ARM: exynos4: Add devicetree node for TMU driver
  ARM: exynos5: Add devicetree node for TMU driver

 arch/arm/boot/dts/exynos4210.dtsi        |    7 +++++++
 arch/arm/boot/dts/exynos5250.dtsi        |    6 ++++++
 arch/arm/mach-exynos/clock-exynos4.c     |    5 +++++
 arch/arm/mach-exynos/clock-exynos5.c     |    5 +++++
 arch/arm/mach-exynos/include/mach/irqs.h |    3 +++
 arch/arm/mach-exynos/include/mach/map.h  |    3 +++
 arch/arm/mach-exynos/mach-exynos4-dt.c   |    2 ++
 arch/arm/mach-exynos/mach-exynos5-dt.c   |    2 ++
 8 files changed, 33 insertions(+), 0 deletions(-)
