From: tony@atomide.com (Tony Lindgren)
Date: Wed, 23 Oct 2013 07:36:42 -0700
Subject: [GIT PULL 1/4] omap late not urgent fixes part 2 for v3.13 merge
 window
Message-ID: <pull-1382539003-174282>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 8ff875e7f93e900e7a7e78f1c9c05a22b33c27cf:

  ARM: mach-omap1: Fix omap1510_fpga_init_irq() implicit declarations. (2013-10-08 11:04:22 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.13/fixes-not-urgent-part2

for you to fetch changes up to 0bebda684857f76548ea48c8886785198701d8d3:

  ARM: OMAP2+: irq, AM33XX add missing register check (2013-10-22 07:50:18 -0700)

----------------------------------------------------------------
Few more omap fixes that are not regressions or oopses and can
wait for the merge window.

----------------------------------------------------------------
Afzal Mohammed (1):
      ARM: OMAP2+: wakeupgen: AM43x adaptation

Markus Pargmann (1):
      ARM: OMAP2+: irq, AM33XX add missing register check

 arch/arm/mach-omap2/irq.c            |  2 +-
 arch/arm/mach-omap2/omap-wakeupgen.c | 18 +++++++++++++-----
 2 files changed, 14 insertions(+), 6 deletions(-)
