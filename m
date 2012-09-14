From: tony@atomide.com (Tony Lindgren)
Date: Thu, 13 Sep 2012 19:34:12 -0700
Subject: [GIT PULL 7/7] am33xx hwmod data for v3.7 merge window
In-Reply-To: <pull-1347590052-683636>
Message-ID: <mailman.13.1347590117.1458.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 68cb700c59fae6cd539c9dc1e9f2584f671935a0:

  ARM: OMAP1: Move SoC specific headers from plat to mach for omap1 (2012-09-12 18:06:31 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-devel-am33xx-for-v3.7

for you to fetch changes up to 11964f53eb4d9ce59a058be9999d9cfcb1ced878:

  Merge tag 'omap-devel-a2-for-3.7' of git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending into devel-am33xx (2012-09-12 21:29:07 -0700)

----------------------------------------------------------------

>From Paul Walmsley <paul@pwsan.com>:

AM33xx hwmod data and miscellaneous clock and hwmod fixes.  AM33xx
should now boot on mainline after this is applied, according to
Vaibhav.

----------------------------------------------------------------
Tony Lindgren (1):
      Merge tag 'omap-devel-a2-for-3.7' of git://git.kernel.org/.../pjw/omap-pending into devel-am33xx

Vaibhav Hiremath (4):
      ARM: OMAP2+: hwmod: Hook-up am33xx support in omap_hwmod framework
      ARM: OMAP3+: hwmod: Add AM33XX HWMOD data
      ARM: OMAP2+: dpll: Add missing soc_is_am33xx() check for common functions
      ARM: AM33XX: clock: Add dcan clock aliases for device-tree

 arch/arm/mach-omap2/Makefile                 |    1 +
 arch/arm/mach-omap2/clkt_dpll.c              |    4 +-
 arch/arm/mach-omap2/clock33xx_data.c         |    2 +
 arch/arm/mach-omap2/dpll3xxx.c               |    4 +-
 arch/arm/mach-omap2/io.c                     |    2 +
 arch/arm/mach-omap2/omap_hwmod.c             |  178 ++
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c   | 3381 ++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    1 +
 8 files changed, 3569 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_33xx_data.c
