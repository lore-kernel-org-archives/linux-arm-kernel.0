From: khilman@ti.com (Kevin Hilman)
Date: Thu, 23 Jun 2011 17:37:15 -0700
Subject: [GIT PULL] misc. OMAP PM updates for v3.1
Message-ID: <87vcvw5akk.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony,

Please pull the following misc. OMAP PM updates targetted for v3.1.

This branch is based on your 'fixes' branch due to some dependencies.

Kevin


The following changes since commit b8ce9fb8e18af7466e0b915bb5979322cdace322:

  Merge branch 'fixes-v3.0-rc3' into devel-fixes (2011-06-14 05:53:42 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_3.1/pm-misc

Kevin Hilman (4):
      OMAP3: PM debug: remove sleep_while_idle feature
      OMAP2: PM debug: remove register dumping
      OMAP3: PM debug: remove register dumping
      OMAP2: PM debug: move wakeup timer into clockevent code

Nishanth Menon (4):
      OMAP3+: SR: make notify independent of class
      OMAP3+: SR: disable interrupt by default
      OMAP3+: SR: enable/disable SR only on need
      OMAP3+: SR: fix cosmetic indentation

Sanjeev Premi (1):
      OMAP2+: PM: fix section mismatch in pm_dbg_init()

 arch/arm/mach-omap2/pm-debug.c            |  364 +----------------------------
 arch/arm/mach-omap2/pm.h                  |    9 -
 arch/arm/mach-omap2/pm24xx.c              |    6 +-
 arch/arm/mach-omap2/pm34xx.c              |    6 -
 arch/arm/mach-omap2/smartreflex.c         |   38 ++--
 arch/arm/mach-omap2/timer-gp.c            |   33 +++-
 arch/arm/plat-omap/include/plat/dmtimer.h |    1 -
 7 files changed, 53 insertions(+), 404 deletions(-)
