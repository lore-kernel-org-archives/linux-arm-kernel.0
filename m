From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 31 May 2014 05:00:01 +0900
Subject: [GIT PULL 4/5] Samsung Exynos MCPM-2 for 3.16
Message-ID: <5388E341.6070608@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit ccf5511797cd4b48d20a85fa1778f5608eac9fd7:

   ARM: EXYNOS: Add MCPM call-back functions (2014-05-16 04:26:30 +0900)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
tags/exynos-mcpm-2

for you to fetch changes up to 7c5688e7fd722690e636c64630ad56babb589e96:

   ARM: EXYNOS: mcpm rename the power_down_finish (2014-05-31 03:01:36 
+0900)

----------------------------------------------------------------
Exynos 2nd MCPM updates for v3.16

- enable mcpm for dual-cluster exynos5800
- since commit 166aaf39 ("ARM: 8029/1: mcpm: Rename the
   power_down_finish() functions to be less confusing"),
   use new member name wait_for_cpu_powerdown.

This is based on tags/exynos-mcpm.

Note that since the commit 166aaf39 is in rmk tree so this
should be sent to upstream after that in 3.16 merge window.

----------------------------------------------------------------
Abhilash Kesavan (1):
       ARM: EXYNOS: Enable mcpm for dual-cluster exynos5800 SoC

Kukjin Kim (1):
       ARM: EXYNOS: mcpm rename the power_down_finish

  arch/arm/mach-exynos/mcpm-exynos.c | 12 +++++++++---
  1 file changed, 9 insertions(+), 3 deletions(-)
