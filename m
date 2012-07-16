From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 17 Jul 2012 07:03:57 +0900
Subject: [GIT PULL] Samsung devel for v3.6
Message-ID: <143501cd639e$e6096390$b21c2ab0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof

This is general development for Samsung stuff for v3.6

Please pull from:
  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
next/devel-samsung

If any problems, please let me know.

NOTE: There are some patches I was reviewing and they will be sent to you
soon :)

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit bd0a521e88aa7a06ae7aabaed7ae196ed4ad867a:

  Linux 3.5-rc6 (2012-07-07 17:23:56 -0700)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
next/devel-samsung

Jonghwan Choi (1):
      ARM: EXYNOS: Clear SYS_WDTRESET bit to use watchdog reset

Mark Brown (1):
      ARM: SAMSUNG: Introduce Kconfig variable for Samsung custom clk API

Sachin Kamat (3):
      ARM: EXYNOS: Update HSOTG PHY clock setting for EXYNOS4X12
      ARM: EXYNOS: Make combiner_init function static
      ARM: EXYNOS: Add missing static storage class specifier in pmu.c file

 arch/arm/mach-exynos/common.c                    |    3 +-
 arch/arm/mach-exynos/include/mach/regs-pmu.h     |    5 ++
 arch/arm/mach-exynos/include/mach/regs-usb-phy.h |   20 +++++--
 arch/arm/mach-exynos/pmu.c                       |   18 ++++++-
 arch/arm/mach-exynos/setup-usb-phy.c             |   60
++++++++++++++++------
 arch/arm/plat-samsung/Kconfig                    |    4 ++
 arch/arm/plat-samsung/Makefile                   |    4 +-
 arch/arm/plat-samsung/include/plat/cpu.h         |    4 ++
 8 files changed, 92 insertions(+), 26 deletions(-)
