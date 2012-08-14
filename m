From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 14 Aug 2012 19:44:42 -0400
Subject: [GIT PULL] orion/kirkwood fixes for v3.6
Message-ID: <20120814234442.GZ22226@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 0d7614f09c1ebdbaa1599a5aba7593f147bf96ee:

  Linux 3.6-rc1 (2012-08-02 16:38:10 -0700)

are available in the git repository at:
  git://git.infradead.org/users/jcooper/linux.git fixes-for-v3.6

Arnaud Patard (3):
      ARM: Orion: Set eth packet size csum offload limit
      ARM: Kirkwood: Fix iconnect leds
      ARM: Kirkwood: fix Makefile.boot

 arch/arm/boot/dts/kirkwood-iconnect.dts   |    6 +++++-
 arch/arm/mach-dove/common.c               |    3 ++-
 arch/arm/mach-kirkwood/Makefile.boot      |    3 ++-
 arch/arm/mach-kirkwood/common.c           |    4 ++--
 arch/arm/mach-mv78xx0/common.c            |    6 ++++--
 arch/arm/mach-orion5x/common.c            |    3 ++-
 arch/arm/plat-orion/common.c              |    8 ++++++--
 arch/arm/plat-orion/include/plat/common.h |    6 ++++--
 include/linux/mv643xx_eth.h               |    2 ++
 9 files changed, 29 insertions(+), 12 deletions(-)
