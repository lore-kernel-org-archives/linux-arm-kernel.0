From: tony@atomide.com (Tony Lindgren)
Date: Sat, 9 Feb 2013 20:19:49 -0800
Subject: [GIT PULL] omap multiplatform warning fixes for v3.9 merge window
Message-ID: <20130210041949.GG4801@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit ad1bb1b4e01c5ecbe32133ce6921d0e76cb76dcf:

  ARM: OMAP2+: Remove now obsolete uncompress.h and debug-macro.S (2013-01-11 11:24:20 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.9/multiplatform-fixes-signed-v2

for you to fetch changes up to 09cee18dbced86b27c6c7d4501126cf2a287d089:

  ARM: OMAP2+: Make sure files with omap initcalls include soc.h (2013-02-09 19:20:57 -0800)

----------------------------------------------------------------
Few trivial compile warning fixes if omap initcalls are
used but soc.h is not included.

----------------------------------------------------------------
Andr? Hentschel (1):
      ARM: OMAP2+: Include soc.h to drm.c to fix compiling

Tony Lindgren (2):
      ARM: OMAP2+: Fix warning for hwspinlock omap_postcore_initcall
      ARM: OMAP2+: Make sure files with omap initcalls include soc.h

 arch/arm/mach-omap2/drm.c                | 1 +
 arch/arm/mach-omap2/hwspinlock.c         | 1 +
 arch/arm/mach-omap2/omap-iommu.c         | 1 +
 arch/arm/mach-omap2/smartreflex-class3.c | 1 +
 4 files changed, 4 insertions(+)
