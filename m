From: horms@verge.net.au (Simon Horman)
Date: Wed,  7 Nov 2012 17:40:04 +0900
Subject: [GIT PULL] Renesas ARM-based SoC boards for v3.8 #2
Message-ID: <1352277607-24040-1-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Arnd,

please consider the following board enhancements for 3.8.

* This pull-request is based on an earlier request which I
  posted on the 1st and was merged yesterday: [GIT PULL v3] Renesas
  ARM-based SoC boards for v3.8

* Patch #2 of this series has a build-time dependency on
  the soc pull request that I sent a few minutes ago:
  [GIT PULL] Renesas ARM-based SoC for v3.8 #2

  In particular, "ARM: shmobile: marzen: add USB EHCI driver support"
  depends on "[PATCH 1/7] ARM: shmobile: r8a7779: PFC rename PENCx -> USB_PENCx"

----------------------------------------------------------------
The following changes since commit 631a7b5d958d2ef2c2333b105794c693642f0641:

  ARM: shmobile: Remove G4EVM machine support (2012-10-30 15:25:59 +0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git boards

for you to fetch changes up to 17eada911c88304005bc0acfdd5ae673fb1f2952:

  ARM: shmobile: marzen: add USB OHCI driver support (2012-11-07 17:15:29 +0900)

----------------------------------------------------------------
Kuninori Morimoto (3):
      ARM: shmobile: marzen: add USB phy support
      ARM: shmobile: marzen: add USB EHCI driver support
      ARM: shmobile: marzen: add USB OHCI driver support

 arch/arm/configs/marzen_defconfig     |   14 ++-
 arch/arm/mach-shmobile/Kconfig        |    2 +
 arch/arm/mach-shmobile/board-marzen.c |  186 ++++++++++++++++++++++++++++++++-
 3 files changed, 198 insertions(+), 4 deletions(-)
