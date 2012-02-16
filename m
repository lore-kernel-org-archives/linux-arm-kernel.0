From: khilman@ti.com (Kevin Hilman)
Date: Thu, 16 Feb 2012 12:45:13 -0800
Subject: [GIT PULL] ARM: OMAP: PM fixes for 3.3-rc
Message-ID: <87wr7mecdi.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

Here's a couple more OMAP PM fixes for v3.3-rc

Kevin

The following changes since commit d65b4e98d7ea3038b767b70fe8be959b2913f16d:

  Linux 3.3-rc3 (2012-02-08 19:21:53 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_3.3/fixes/pm

for you to fetch changes up to 03e4fd6eb25e6b46536ecdb0d1b7d33d46b15480:

  ARM: OMAP4: cpuidle: Fix the C-state reporting to cpuidle governor. (2012-02-14 10:59:26 -0800)

----------------------------------------------------------------
NeilBrown (1):
      ARM: OMAP: add RCU locking to omap2_set_init_voltage.

Santosh Shilimkar (1):
      ARM: OMAP4: cpuidle: Fix the C-state reporting to cpuidle governor.

 arch/arm/mach-omap2/cpuidle44xx.c |    5 ++---
 arch/arm/mach-omap2/pm.c          |    3 +++
 2 files changed, 5 insertions(+), 3 deletions(-)
