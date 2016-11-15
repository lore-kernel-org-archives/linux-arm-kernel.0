From: tony@atomide.com (Tony Lindgren)
Date: Tue, 15 Nov 2016 13:22:19 -0800
Subject: [GIT PULL 1/5] non-urgent omap fixes for v4.10
Message-ID: <pull-1479236877-351747>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.10/fixes-not-urgent-signed

for you to fetch changes up to 5c02b01d234f8410010c952069d3fb9ec5d9124a:

  ARM: OMAP2+: pm-debug: Use seq_putc() in two functions (2016-11-09 15:33:33 -0700)

----------------------------------------------------------------
Non-urgent fixes for omaps for v4.10 merge window:

- Fix mismatched interrupt numbers for tps65217, these are not yet
  used

- Remove unused omapdss_early_init_of()

- Use seq_putc() for pm-debug.c

----------------------------------------------------------------
Laurent Pinchart (1):
      ARM: OMAP2+: Remove the omapdss_early_init_of() function

Markus Elfring (1):
      ARM: OMAP2+: pm-debug: Use seq_putc() in two functions

Milo Kim (1):
      mfd: tps65217: Fix mismatched interrupt number

 arch/arm/mach-omap2/board-generic.c |  2 --
 arch/arm/mach-omap2/common.h        |  1 -
 arch/arm/mach-omap2/display.c       |  5 -----
 arch/arm/mach-omap2/pm-debug.c      |  5 ++---
 include/linux/mfd/tps65217.h        | 11 +++++------
 5 files changed, 7 insertions(+), 17 deletions(-)
