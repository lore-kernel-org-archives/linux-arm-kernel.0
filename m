From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 16 Dec 2011 16:33:12 +0900
Subject: [GIT PULL] Samsung fixes-3 for v3.2
Message-ID: <014801ccbbc4$f7954200$e6bfc600$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

Please pull 3rd Samsung fixes for v3.2.
If any problems, please let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit dc47ce90c3a822cd7c9e9339fe4d5f61dcb26b50:

  Linux 3.2-rc5 (2011-12-09 15:09:32 -0800)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
samsung-fixes-3

Amit Daniel Kachhap (1):
      ARM: EXYNOS: Fix for stall in case of cpu hotplug or sleep

Jingoo Han (2):
      ARM: SAMSUNG: remove duplicated header include
      ARM: S5PV210: Set 1000ns as PWM backlight period on SMDKV210

Kukjin Kim (1):
      ARM: EXYNOS: Fix build error without CONFIG_LOCAL_TIMERS

 arch/arm/mach-exynos/mct.c            |   13 ++++++++++---
 arch/arm/mach-s5pv210/mach-smdkv210.c |    1 +
 arch/arm/plat-samsung/dev-backlight.c |    1 -
 3 files changed, 11 insertions(+), 4 deletions(-)
