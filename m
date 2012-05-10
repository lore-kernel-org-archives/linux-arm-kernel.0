From: tony@atomide.com (Tony Lindgren)
Date: Thu, 10 May 2012 11:39:19 -0700
Subject: [GIT PULL 8/10] omap timer cleanup for v3.5 merge window
In-Reply-To: <pull-1336675159-747052>
Message-ID: <mailman.16.1336675232.1417.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit bfd17879866b36e95c58721da070d9f2ac7f8901:

  Merge tag 'omap-devel-c-for-3.5' of git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending into devel-hwmod-data (2012-05-09 09:58:42 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-cleanup-timer-for-v3.5

for you to fetch changes up to 1fe97c8f6a1de67a5f56e029a818903d5bed8017:

  ARM: OMAP: Make OMAP clocksource source selection using kernel param (2012-05-09 10:07:05 -0700)

----------------------------------------------------------------
Timer changes to make it easier to support various SoCs

----------------------------------------------------------------
Vaibhav Hiremath (3):
      ARM: OMAP1: Add checks for possible error condition in timer_init
      ARM: OMAP2+: Replace space with underscore in the name field of system timers
      ARM: OMAP: Make OMAP clocksource source selection using kernel param

 arch/arm/mach-omap1/common.h             |    9 ++-
 arch/arm/mach-omap1/time.c               |   16 +---
 arch/arm/mach-omap1/timer32k.c           |   28 ++++++-
 arch/arm/mach-omap2/timer.c              |  118 +++++++++++++++++++++++-------
 arch/arm/plat-omap/counter_32k.c         |   91 ++++++++++-------------
 arch/arm/plat-omap/include/plat/common.h |    2 +-
 6 files changed, 166 insertions(+), 98 deletions(-)
