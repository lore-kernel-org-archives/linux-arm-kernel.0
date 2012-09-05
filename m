From: horms@verge.net.au (Simon Horman)
Date: Wed,  5 Sep 2012 10:34:50 +0900
Subject: [GIT PULL] Renesas ARM-based SoC fix for v3.6 #2
Message-ID: <1346808893-14124-1-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Arnd,

please consider the following fixes for the Armadillo800 EVA and
Mackerel boards from Morimoto-san.

* "ARM: shmobile: armadillo800eva: fixup: sound card detection order"
  is a regression fix.
* "ARM: shmobile: mackerel: fixup usb module order"
  is a regression fix.
* "ARM: shmobile: armadillo800eva: enable rw rootfs mount"
  is a boot-loader compatibility fix.

All of the changes are aimed at improving the end-user experience.

Notes:

* This pull request is based on my previous
  "[GIT PULL] Renesas ARM-based SoC fix for v3.6" pull request
  which was recently pulled by Olof. Please let me know
  if you would like me to handle this a different way.

----------------------------------------------------------------
The following changes since commit 497dcf6fc355f0734faf851662b6957386715d24:

  ARM: shmobile: marzen: fixup smsc911x id for regulator (2012-08-30 14:10:08 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git fixes

for you to fetch changes up to 28e515878f8896b33c325ff9767cb0237210fb4c:

  ARM: shmobile: armadillo800eva: enable rw rootfs mount (2012-09-03 17:31:34 +0900)

----------------------------------------------------------------
Kuninori Morimoto (3):
      ARM: shmobile: armadillo800eva: fixup: sound card detection order
      ARM: shmobile: mackerel: fixup usb module order
      ARM: shmobile: armadillo800eva: enable rw rootfs mount

 arch/arm/configs/armadillo800eva_defconfig     |    2 +-
 arch/arm/mach-shmobile/board-armadillo800eva.c |    2 +-
 arch/arm/mach-shmobile/board-mackerel.c        |    3 ++-
 3 files changed, 4 insertions(+), 3 deletions(-)
