From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 18 Jul 2014 17:32:14 -0400
Subject: [GIT PULL] ARM: mvebu: Fixes for v3.16 (round 3)
Message-ID: <20140718213214.GL24496@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All,

Here is hopefully the last round of fixes for mvebu.

This is an incremental pull request from tags/mvebu-fixes-3.16-2 up to
tags/mvebu-fixes-3.16-3 on the mvebu/fixes branch.

Please pull.

thx,

Jason.

The following changes since commit 6509dc74c9f55ffaa558738b96c4da8b98d39571:

  ARM: mvebu: fix cpuidle implementation to work on big-endian systems (2014-06-30 18:15:11 +0000)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-fixes-3.16-3

for you to fetch changes up to a728b977429383b3fe92b6e3bff9e69365609e0f:

  ARM: mvebu: Fix coherency bus notifiers by using separate notifiers (2014-07-08 13:53:53 +0000)

----------------------------------------------------------------
mvebu fixes for v3.16 (round 3)

 - Fix SMP boot on 38x/375 in big endian
 - Fix operand list for pmsu on 370/XP
 - Fix coherency bus notifiers

----------------------------------------------------------------
Ezequiel Garcia (1):
      ARM: mvebu: Fix coherency bus notifiers by using separate notifiers

Gregory CLEMENT (1):
      ARM: mvebu: Fix the operand list in the inline asm of armada_370_xp_pmsu_idle_enter

Thomas Petazzoni (1):
      ARM: mvebu: fix SMP boot for Armada 38x and Armada 375 Z1 in big endian

 arch/arm/mach-mvebu/coherency.c  |  6 +++++-
 arch/arm/mach-mvebu/headsmp-a9.S |  9 ++++++++-
 arch/arm/mach-mvebu/pmsu.c       | 10 +++++-----
 3 files changed, 18 insertions(+), 7 deletions(-)
