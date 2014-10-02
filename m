From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 2 Oct 2014 09:59:26 -0400
Subject: [GIT PULL] ARM: mvebu: Last DT changes for v3.18
Message-ID: <20141002135926.GC27230@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Guys,

I know this is way late, but the changes a fairly small, and have been
in linux-next for at least 9 of Stephen's 'next-YYYYMMDD' tags.
Hopefully the merge window opening a week late will make it possible for
you guys to take this.

This is an incremental pull request from tags/mvebu-dt-3.18 up to
tags/mvebu-dt-3.18-2 on the mvebu/dt branch.

Please pull.

thx,

Jason.


The following changes since commit 5b1e9e80c044442cc80eb6bb03b11165515eedb8:

  ARM: mvebu: add user LED support of Armada 370 RD (2014-09-13 21:13:42 +0000)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt-3.18-2

for you to fetch changes up to 32c741d07f7fdb1974eb07420fc143d479bfe19f:

  ARM: mvebu: switch the Armada 370 RD board to internal registers at 0xf1000000 (2014-09-17 15:00:59 +0000)

----------------------------------------------------------------
mvebu DT changes for v3.18 (round 2)

 - Armada XP
    - Add HW datasheet references to docs

 - Armada 370
    - Change internal registers to 0xf1000000 for Armada 370 RD board

----------------------------------------------------------------
Thomas Petazzoni (2):
      Documentation: arm: add hardware datasheet reference for Marvell Armada XP
      ARM: mvebu: switch the Armada 370 RD board to internal registers at 0xf1000000

 Documentation/arm/Marvell/README    |  4 ++++
 arch/arm/boot/dts/armada-370-rd.dts | 11 ++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)
