From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 14 May 2012 22:09:49 -0400
Subject: [GIT PULL] ARM: marvell: cleanup for v3.5
Message-ID: <20120515020949.GU16338@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit d48b97b403d23f6df0b990cee652bdf9a52337a3:

  Linux 3.4-rc6 (2012-05-06 15:07:32 -0700)

are available in the git repository at:
  git://git.infradead.org/users/jcooper/linux.git marvell_cleanup_for_v3.5

Alexander Clouter (4):
      ARM: orion5x: ts78xx whitespace cleanups
      ARM: orion5x: ts78xx fix NAND resource off by one
      ARM: orion5x: remove PM dependency from ts78xx
      ARM: orion5x: ts78xx debugging changes

Andrew Lunn (3):
      Orion5x: Fix warning: struct pci_dev declared inside paramter list
      Orion5x: Fix Section mismatch warnings
      Dove: Fix Section mismatch warnings

 arch/arm/mach-dove/common.c          |    2 +-
 arch/arm/mach-dove/mpp.c             |    8 ++--
 arch/arm/mach-orion5x/Kconfig        |    1 -
 arch/arm/mach-orion5x/addr-map.c     |    2 +-
 arch/arm/mach-orion5x/common.c       |    2 +-
 arch/arm/mach-orion5x/common.h       |    1 +
 arch/arm/mach-orion5x/ts78xx-fpga.h  |    6 ++--
 arch/arm/mach-orion5x/ts78xx-setup.c |   52 +++++++++++++++------------------
 8 files changed, 35 insertions(+), 39 deletions(-)
