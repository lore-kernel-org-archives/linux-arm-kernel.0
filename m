From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Wed, 07 Nov 2012 16:16:57 +0530
Subject: [PATCH 0/3] Legacy I2C controller fixes for exynos5
Message-ID: <1352285220-31544-1-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset comprises fixes to enable the legacy I2C controller on exynos5.
Based on git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
for-next branch.

Abhilash Kesavan (3):
  ARM: EXYNOS5: Setup legacy i2c controller interrupts on SMDK5250
  ARM: EXYNOS5: Add aliases for i2c controller
  ARM: EXYNOS5: Fix i2c suspend/resume for legacy controller

 arch/arm/boot/dts/exynos5250.dtsi            |   27 +++++++++++++++++--------
 arch/arm/mach-exynos/include/mach/regs-pmu.h |    2 +
 arch/arm/mach-exynos/mach-exynos5-dt.c       |   24 +++++++++++++++++++++++
 arch/arm/mach-exynos/pm.c                    |    9 ++++++++
 4 files changed, 53 insertions(+), 9 deletions(-)
