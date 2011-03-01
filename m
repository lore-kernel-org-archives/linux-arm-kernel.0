From: khilman@ti.com (Kevin Hilman)
Date: Tue, 01 Mar 2011 15:14:35 -0800
Subject: [GIT PULL] OMAP PM fixes for 2.6.38-rc
Message-ID: <87pqqae8mc.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony,

Here's a final batch of PM fixes for the 2.6.38-rc cycle.

Kevin

The following changes since commit f5412be599602124d2bdd49947b231dd77c0bf99:

  Linux 2.6.38-rc6 (2011-02-21 17:25:52 -0800)

are available in the git repository at:
  ssh://master.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_2.6.38/pm-fixes

Aaro Koskinen (1):
      arm: mach-omap2: smartreflex: fix another memory leak

Shweta Gulati (1):
      OMAP2+: PM: SmartReflex: fix memory leaks in Smartreflex driver

Vasiliy Kulikov (3):
      mach-omap2: mux: world-writable debugfs files
      mach-omap2: pm: world-writable debugfs timer files
      mach-omap2: smartreflex: world-writable debugfs voltage files

 arch/arm/mach-omap2/mux.c         |    2 +-
 arch/arm/mach-omap2/pm-debug.c    |    8 ++++----
 arch/arm/mach-omap2/smartreflex.c |   37 +++++++++++++++++--------------------
 3 files changed, 22 insertions(+), 25 deletions(-)
