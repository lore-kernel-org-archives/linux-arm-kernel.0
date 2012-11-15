From: tony@atomide.com (Tony Lindgren)
Date: Wed, 14 Nov 2012 18:56:43 -0800
Subject: [GIT PULL 2/5] omap cleanup fix and soc detection improvment for v3.8
 merge window
In-Reply-To: <pull-1352948204-277861>
Message-ID: <mailman.3.1352948223.1035.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit e05cf58d50e3ce3601ebf753728eee0df759e38f:

  ARM: OMAP2+: remove duplicated include from board-overo.c (2012-11-12 14:02:48 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.8/cleanup-fixes-part2-v2-signed

for you to fetch changes up to 42a1cc9c0ec2a00b53b4f02849dc4377b09b3b05:

  ARM: OMAP4: ID: Improve features detection and check (2012-11-14 12:10:37 -0800)

----------------------------------------------------------------
One build fix for recent clean up when CONFIG_PM is not set
and clean up related improvment to the SoC detection.

----------------------------------------------------------------
Ivan Khoronzhuk (1):
      ARM: OMAP4: ID: Improve features detection and check

Tony Lindgren (1):
      ARM: OMAP: Fix compile for OMAP_PM_NOOP if PM is not selected

 arch/arm/mach-omap2/Makefile |  3 ++-
 arch/arm/mach-omap2/id.c     | 25 +++++++------------------
 arch/arm/mach-omap2/soc.h    |  8 ++------
 3 files changed, 11 insertions(+), 25 deletions(-)
