From: tony@atomide.com (Tony Lindgren)
Date: Thu, 8 Mar 2012 12:53:29 -0800
Subject: [GIT PULL 4/7] tiny uart clean-up for upcoming merge window
In-Reply-To: <pull-1331240009-558004>
Message-ID: <mailman.6.1331240034.14256.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This one contains removal of some now unneded code.
Also suggested to pull into cleanup branch.


The following changes since commit b01543dfe67bb1d191998e90d20534dc354de059:
  Linus Torvalds (1):
        Linux 3.3-rc4

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap uart

NeilBrown (2):
      ARM: OMAP2+: UART: remove unused fields in omap_uart_state.
      ARM: OMAP2+: remove some orphan function declarations.

Tony Lindgren (1):
      Merge branch 'for_3.4/cleanup/uart' of git://git.kernel.org/.../khilman/linux-omap-pm into uart

 arch/arm/mach-omap2/pm.h                 |    1 -
 arch/arm/mach-omap2/serial.c             |    4 ----
 arch/arm/plat-omap/include/plat/serial.h |    1 -
 3 files changed, 0 insertions(+), 6 deletions(-)
