From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 25 Nov 2014 23:51:50 -0500
Subject: [GIT PULL] ARM: mvebu: Fixes for v3.18 (round 2)
Message-ID: <20141126045150.GM22670@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All,

One last fix for v3.18.  Been in -next a few days.

This is an incremental pull request from tags/mvebu-fixes-3.18 up to
tags/mvebu-fixes-3.18-2 on the mvebu/fixes branch.

Please pull.

thx,

Jason.


The following changes since commit 9ece8839b1277fb9128ff6833411614ab6c88d68:

  ARM: orion: Fix for certain sequence of request_irq can cause irq storm (2014-11-01 22:07:45 +0000)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-fixes-3.18-2

for you to fetch changes up to 2eb04ae010a8fb165ba7aa56e9aa8e7980887dee:

  ARM: mvebu: add missing of_node_put() call in coherency.c (2014-11-07 02:56:36 +0000)

----------------------------------------------------------------
mvebu fixes for v3.18 (round 2)

 - mvebu
    - coherency.c needed an of_node_put()

----------------------------------------------------------------
Thomas Petazzoni (1):
      ARM: mvebu: add missing of_node_put() call in coherency.c

 arch/arm/mach-mvebu/coherency.c | 2 ++
 1 file changed, 2 insertions(+)
