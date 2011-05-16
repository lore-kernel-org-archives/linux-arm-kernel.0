From: tony@atomide.com (Tony Lindgren)
Date: Mon, 16 May 2011 04:43:19 -0700
Subject: [GIT PULL] Two omap fixes for v2.6.39-rc7
Message-ID: <20110516114318.GB1780@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull two omap fixes from:

git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap-fixes-for-linus

This contains one iommu regression fix and one clock fix.

Regards,

Tony


The following changes since commit 693d92a1bbc9e42681c42ed190bd42b636ca876f:
  Linus Torvalds (1):
        Linux 2.6.39-rc7

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap-fixes-for-linus

Avinash H.M (1):
      OMAP3: set the core dpll clk rate in its set_rate function

Laurent Pinchart (1):
      omap: iommu: Return IRQ_HANDLED in fault handler when no fault occured

 arch/arm/mach-omap2/clkt34xx_dpll3m2.c |    1 +
 arch/arm/plat-omap/iommu.c             |    2 ++
 2 files changed, 3 insertions(+), 0 deletions(-)
