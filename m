From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 23 Jul 2014 08:18:47 -0400
Subject: [GIT PULL] ARM: mvebu: DT fixes for v3.17 (round 3)
Message-ID: <20140723121847.GD23220@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All,

This is a small round of fixes for new nodes adding ethernet support to
Armada 375.  Since the nodes were only added for v3.17, these patches
are queued for v3.17, instead of as fixes for v3.16-rcX.

This is an incremental pull request from tags/mvebu-dt-3.17-2 up to
tags/mvebu-dt-3.17-3 on the mvebu/dt branch.

Please pull.

thx,

Jason.


The following changes since commit 3843607838cc5436d02a6771e661969a54c2fee0:

  ARM: mvebu: update Armada XP DT for dynamic frequency scaling (2014-07-16 12:54:13 +0000)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt-3.17-3

for you to fetch changes up to 112dc53db1c27594e3b1504189c2004115fb1914:

  ARM: mvebu: Add missing MDIO clock in Armada 375 (2014-07-23 12:04:40 +0000)

----------------------------------------------------------------
mvebu DT changes for v3.17 (round 3)

 - Armada 375
    - Fix ethernet aliases for new node added for v3.17
    - Add missing MDIO clock for new node added for v3.17

----------------------------------------------------------------
Ezequiel Garcia (1):
      ARM: mvebu: Add missing MDIO clock in Armada 375

Marcin Wojtas (1):
      ARM: mvebu: Add ethernet aliases required by U-Boot

 arch/arm/boot/dts/armada-375.dtsi | 3 +++
 1 file changed, 3 insertions(+)
