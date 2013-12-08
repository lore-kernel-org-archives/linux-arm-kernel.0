From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 7 Dec 2013 19:32:36 -0500
Subject: [GIT PULL] ARM: mvebu: DT changes for v3.14 (set #2)
Message-ID: <20131208003236.GD11251@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Guys,

Nothing big here, Arnaud's been busy wit hthe Netgear boards ;-)

In -next for 5 days or so.

This is an incremental pull, from tags/mvebu-dt-3.14 in mvebu/dt branch.
Olof pulled the first set into arm-soc/cleanup, so this branch will
depend upon that.

thx,

Jason.


The following changes since commit bd22bb23919e6727967e90eb89bb41ab790bcd2d:

  ARM: Dove: Add RTC interrupt via PMU interrupt controller. (2013-11-26 16:10:49 +0000)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt-3.14-2

for you to fetch changes up to 46ca506c43d64e11257a0a113701e9bcccf52416:

  ARM: kirkwood: Add support for NETGEAR ReadyNAS NV+ v2 (2013-12-01 22:18:44 +0000)

----------------------------------------------------------------
mvebu DT changes for v3.14 (set #2)

 - mvebu
    - Netgear ReadyNAS cleanup
    - add Netgear ReadyNAS 2120

 - kirkwood
    - Netgear ReadyNAS cleanup
    - add Netgear ReadyNAS NV+ v2

----------------------------------------------------------------
Arnaud Ebalard (6):
      ARM: kirkwood: NETGEAR ReadyNAS Duo v2 .dts cleanup
      ARM: mvebu: NETGEAR ReadyNAS 102 .dts cleanup
      ARM: mvebu: NETGEAR ReadyNAS 104 .dts cleanup
      ARM: mvebu: Fix whitespace in NETGEAR ReadyNAS .dts files
      ARM: mvebu: Add Netgear ReadyNAS 2120 board
      ARM: kirkwood: Add support for NETGEAR ReadyNAS NV+ v2

 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/armada-370-netgear-rn102.dts     |  82 +++---
 arch/arm/boot/dts/armada-370-netgear-rn104.dts     |  68 +++--
 arch/arm/boot/dts/armada-xp-netgear-rn2120.dts     | 286 +++++++++++++++++++++
 .../boot/dts/kirkwood-netgear_readynas_duo_v2.dts  |  99 ++++---
 .../boot/dts/kirkwood-netgear_readynas_nv+_v2.dts  | 270 +++++++++++++++++++
 6 files changed, 699 insertions(+), 108 deletions(-)
 create mode 100644 arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-netgear_readynas_nv+_v2.dts
