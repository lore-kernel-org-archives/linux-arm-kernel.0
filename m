From: khilman@ti.com (Kevin Hilman)
Date: Tue, 06 Mar 2012 16:15:47 -0800
Subject: [GIT PULL] ARM: OMAP: UART: cleanups for v3.4
Message-ID: <877gyxb70s.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony,

Here are a couple minor cleanups in the serial init code for v3.4.

Kevin


The following changes since commit b01543dfe67bb1d191998e90d20534dc354de059:

  Linux 3.3-rc4 (2012-02-18 15:53:33 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_3.4/cleanup/uart

for you to fetch changes up to 7cb034f8179dfc2889c1f2341566ee68f648a324:

  ARM: OMAP2+: remove some orphan function declarations. (2012-02-21 11:13:11 -0800)

----------------------------------------------------------------
NeilBrown (2):
      ARM: OMAP2+: UART: remove unused fields in omap_uart_state.
      ARM: OMAP2+: remove some orphan function declarations.

 arch/arm/mach-omap2/pm.h                 |    1 -
 arch/arm/mach-omap2/serial.c             |    4 ----
 arch/arm/plat-omap/include/plat/serial.h |    1 -
 3 files changed, 6 deletions(-)
