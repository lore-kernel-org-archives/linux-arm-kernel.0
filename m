From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 15 Sep 2011 18:56:28 +0900
Subject: [GIT PULL] Samsung Fixes for v3.1-rc7
Message-ID: <00b101cc738d$bcf46ce0$36dd46a0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd :)

This is Samsung fixes for v3.1

Please pull from:
  git://github.com/kgene/linux-samsung.git samsung-fixes-2
As you know, git.kernel.org/master.kernel.org has been down so I use
temporary git repo. at github now.

These things are needed for v3.1 and if any problems, please let me know.

As a note, others for v3.2 will be sent in the next week...

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit b6fd41e29dea9c6753b1843a77e50433e6123bcb:

  Linux 3.1-rc6 (2011-09-12 14:02:02 -0700)

are available in the git repository at:
  git://github.com/kgene/linux-samsung.git samsung-fixes-2

Banajit Goswami (1):
      ARM: S3C64XX: Remove un-used code backlight code on SMDK6410

Changhwan Youn (1):
      ARM: EXYNOS4: restart clocksource while system resumes

Jonghwan Choi (1):
      ARM: EXYNOS4: Fix wrong pll type for vpll

Kukjin Kim (3):
      ARM: EXYNOS4: Fix return type of local_timer_setup()
      ARM: EXYNOS4: Fix routing timer interrupt to offline CPU
      ARM: SAMSUNG: fix to prevent declaring duplicated

Marek Szyprowski (1):
      ARM: SAMSUNG: fix watchdog reset issue with clk_get()

Thomas Abraham (1):
      ARM: EXYNOS4: fix incorrect pad configuration for keypad row lines

 arch/arm/mach-exynos4/clock.c                      |    2 +-
 arch/arm/mach-exynos4/mct.c                        |   10 +++++-
 arch/arm/mach-exynos4/platsmp.c                    |    2 +
 arch/arm/mach-exynos4/setup-keypad.c               |   11 +++---
 arch/arm/mach-s3c64xx/mach-smdk6410.c              |   39
--------------------
 arch/arm/plat-samsung/clock.c                      |   11 ++++++
 arch/arm/plat-samsung/include/plat/clock.h         |    8 ++++
 .../arm/plat-samsung/include/plat/watchdog-reset.h |   10 ++----
 8 files changed, 40 insertions(+), 53 deletions(-)
