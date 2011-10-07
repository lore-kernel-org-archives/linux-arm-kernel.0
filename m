From: khilman@ti.com (Kevin Hilman)
Date: Fri, 07 Oct 2011 14:03:14 -0700
Subject: [GIT PULL] OMAP: few more PM cleanup/fixes for v3.2
Message-ID: <87sjn4jyzx.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony,

Please pull the (hopefully) last few PM fixes/cleanups for v3.2.

Kevin


The following changes since commit 976d167615b64e14bc1491ca51d424e2ba9a5e84:

  Linux 3.1-rc9 (2011-10-04 18:11:50 -0700)

are available in the git repository at:
  git://github.com/khilman/linux-omap-pm.git for_3.2/pm-cleanup-2

Charulatha V (1):
      ARM: OMAP3: PM: fix pwrdm_post_transition call sequence

Paul Walmsley (2):
      ARM: OMAP3: PM: fix I/O wakeup and I/O chain clock control detection
      ARM: OMAP3: PM: restrict erratum i443 handling to OMAP3430 only

 arch/arm/mach-omap2/id.c              |    5 ++-
 arch/arm/mach-omap2/pm34xx.c          |   70 +++++++++++++++++---------------
 arch/arm/plat-omap/include/plat/cpu.h |   17 ++++++--
 3 files changed, 53 insertions(+), 39 deletions(-)
