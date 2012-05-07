From: tony@atomide.com (Tony Lindgren)
Date: Mon, 7 May 2012 15:36:33 -0700
Subject: [GIT PULL] omap fixes for v3.4-rc6
Message-ID: <20120507223632.GP5088@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 69964ea4c7b68c9399f7977aa5b9aa6539a6a98a:

  Linux 3.4-rc5 (2012-04-29 15:19:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-fixes-for-v3.4-rc6

for you to fetch changes up to 4d975027cc327d4486bb74b6908e874f2fee8c47:

  ARM: OMAP: igep0020: Specify the VPLL2 regulator unconditionally (2012-05-04 12:45:21 -0700)

----------------------------------------------------------------
Few more regression fixes that are mostly board specific

----------------------------------------------------------------
Archit Taneja (1):
      ARM: OMAP: Revert "ARM: OMAP: ctrl: Fix CONTROL_DSIPHY register fields"

Enrico Butera (1):
      ARM: OMAP: igep0020: fix smsc911x dummy regulator id

Janusz Krzysztofik (1):
      ARM: OMAP1: Amstrad Delta: Fix wrong IRQ base in FIQ handler

Laurent Pinchart (1):
      ARM: OMAP: igep0020: Specify the VPLL2 regulator unconditionally

 arch/arm/mach-omap1/ams-delta-fiq.c                |    2 +-
 arch/arm/mach-omap2/board-igep0020.c               |   12 ++++++------
 .../include/mach/ctrl_module_pad_core_44xx.h       |    8 ++++----
 3 files changed, 11 insertions(+), 11 deletions(-)
