From: tony@atomide.com (Tony Lindgren)
Date: Wed, 18 Nov 2009 13:51:47 -0800
Subject: [GIT PULL] omap fixes for v2.6.32-rc7
Message-ID: <20091118215147.GT29266@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus,

Please pull few more omap fixes from:

git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap-fixes-for-linus

Regards,

Tony


The following changes since commit 156171c71a0dc4bce12b4408bb1591f8fe32dc1a:
  Linus Torvalds (1):
        Linux 2.6.32-rc7

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap-fixes-for-linus

Rajendra Nayak (1):
      omap3: clock: Fix the DPLL freqsel computations

Roel Kluin (2):
      omap: fix unlikely(x) < y
      OMAP: cs should be positive in gpmc_cs_free()

Tero Kristo (1):
      omap3: clock: Fixed dpll3_m2x2 rate calculation

Vimal Singh (1):
      omap: Fix keymap for zoom2 according to matrix keypad framwork

 arch/arm/mach-omap2/board-zoom2.c |   87 ++++++++++++++++++-------------------
 arch/arm/mach-omap2/clock34xx.c   |    2 +-
 arch/arm/mach-omap2/clock34xx.h   |    4 +-
 arch/arm/mach-omap2/gpmc.c        |    2 +-
 arch/arm/plat-omap/gpio.c         |    2 +-
 5 files changed, 48 insertions(+), 49 deletions(-)
