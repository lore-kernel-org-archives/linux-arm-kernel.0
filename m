From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 31 Oct 2013 09:35:50 -0400
Subject: [GIT PULL] ARM: mvebu: dt changes for v3.13 (really, last one!)
Message-ID: <20131031133550.GM26784@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof,

At your request, here's Thomas' patch adding the Openblocks A7 board.
It made it through -next last night.

thx,

Jason.


The following changes since commit f039dfb51b36a2d7e4ac25e65ffbd03e3ac77a0c:

  ARM: mvebu: Add the core-divider clock to Armada 370/XP (2013-10-23 11:04:31 +0000)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/dt-3.13-5

for you to fetch changes up to f24b56cbcd9d39cb2ed45b4b451f8614f9494c17:

  ARM: kirkwood: add support for OpenBlocks A7 platform (2013-10-30 19:55:34 +0000)

----------------------------------------------------------------
mvebu dt changes for v3.13 (round 5)

 - kirkwood
    - add the Openblocks A7 board

----------------------------------------------------------------
Thomas Petazzoni (1):
      ARM: kirkwood: add support for OpenBlocks A7 platform

 arch/arm/boot/dts/Makefile                   |   5 +-
 arch/arm/boot/dts/kirkwood-openblocks_a7.dts | 223 +++++++++++++++++++++++++++
 2 files changed, 226 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/boot/dts/kirkwood-openblocks_a7.dts
