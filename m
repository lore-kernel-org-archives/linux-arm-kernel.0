From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 21 Jun 2013 12:48:50 -0400
Subject: [GIT PULL 2/2] ARM: mvebu: regmap fix for multiplatform (round 2)
Message-ID: <20130621164850.GU31667@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,


The following changes since commit 5fb2038d61ce94e7c9224db2aaff5633ca224953:

  arm: mvebu: disable DEBUG_LL/EARLY_PRINTK in defconfig (2013-06-13 17:48:59 +0000)

are available in the git repository at:

  git://git.infradead.org/users/jcooper/linux.git tags/regmap-3.11-2

for you to fetch changes up to 1919bff0e25f5f7ce43474a3b972405f51023e99:

  arm: mvebu: fix coherency_late_init() for multiplatform (2013-06-20 12:12:48 +0000)

----------------------------------------------------------------
mvebu register map changes for v3.11 (round 2)

This series removes the hardcoded register base address for mvebu.

For round 2:
 - multiplatform
    - fix booting on anything other than mvebu

Depends (none new for round 2):
 - mvebu/fixes-non-critical (up to tags/fixes-non-3.11-1)
 - mvebu/cleanup (up to tags/cleanup-3.11-3)

----------------------------------------------------------------
Thomas Petazzoni (1):
      arm: mvebu: fix coherency_late_init() for multiplatform

 arch/arm/mach-mvebu/coherency.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)
