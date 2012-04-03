From: khilman@ti.com (Kevin Hilman)
Date: Tue, 03 Apr 2012 11:30:22 -0700
Subject: [GIT PULL] OMAP PM fixes for v3.4-rc
Message-ID: <87zkaspt1d.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony,

Please pull the following OMAP PM fixes for v3.4-rc1.

Thanks,

Kevin


The following changes since commit c16fa4f2ad19908a47c63d8fa436a1178438c7e7:

  Linux 3.3 (2012-03-18 16:15:34 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_3.4/fixes/pm

for you to fetch changes up to 4ba7c3c3c6567210bf46b1ab3d089134170c2762:

  ARM: OMAP3+: fix oops triggered in omap_prcm_register_chain_handler(v1) (2012-03-22 16:11:17 -0700)

----------------------------------------------------------------
Mark A. Greer (2):
      arm: omap3: pm34xx.c: Fix omap3_pm_init() error out paths
      arm: omap3: pm34xx.c: Replace printk() with appropriate pr_*()

Ming Lei (1):
      ARM: OMAP3+: fix oops triggered in omap_prcm_register_chain_handler(v1)

Nishanth Menon (1):
      ARM: OMAP2+: OPP: allow OPP enumeration to continue if device is not present

Santosh Shilimkar (1):
      ARM: OMAP4: Workaround the OCP synchronisation issue with 32K synctimer.

 arch/arm/mach-omap2/opp.c        |    4 ++--
 arch/arm/mach-omap2/pm34xx.c     |   38 ++++++++++++++++++++------------------
 arch/arm/mach-omap2/pm44xx.c     |   10 ++++++++--
 arch/arm/mach-omap2/prm_common.c |    2 +-
 4 files changed, 31 insertions(+), 23 deletions(-)
