From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 28 Aug 2013 10:39:20 +0900
Subject: [GIT PULL 0/3] Fourth round of Renesas ARM based SoC cleanups for
 v3.12
Message-ID: <cover.1377651687.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin, Hi Olof, Hi Arnd,

please consider this fourth round of Renesas ARM based SoC cleanups for v3.12.

It is based on renesas-cleanup3-for-v3.12 ("Third round of ARM based SoC SMP updates for v3.12") which you have previously pulled.

I apologise that this and other pull requests that I will send today
are rather later in the cycle than I would like. This is primarily due
to a combination of my summer vacation and wanting to let the patches
sit in next for a while.


The following changes since commit 282b583f752f996ee5c33b0cdc18adf3b5094ee0:

  ARM: shmobile: sh73a0: Remove global GPIO_NR definition (2013-08-06 18:07:13 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-cleanup4-for-v3.12

for you to fetch changes up to 3cf627b06ffc8f89548941e9cb8e8f1e0fe0f5c5:

  ARM: shmobile: r8a7790: Constify platform data and resources (2013-08-22 10:41:56 +0900)

----------------------------------------------------------------
Fourth round of Renesas ARM based SoC cleanups for v3.12

* Constify platform data for r8a7790 SoC
* Rename r8a7{790,3a4}_init_delay as r8a7{790,3a4}_init_early
  to better reflect their usage

----------------------------------------------------------------
Laurent Pinchart (1):
      ARM: shmobile: r8a7790: Constify platform data and resources

Magnus Damm (2):
      ARM: shmobile: Rename to r8a73a4_init_early()
      ARM: shmobile: Rename to r8a7790_init_early()

 arch/arm/mach-shmobile/board-ape6evm-reference.c |  2 +-
 arch/arm/mach-shmobile/board-ape6evm.c           |  2 +-
 arch/arm/mach-shmobile/board-lager-reference.c   |  2 +-
 arch/arm/mach-shmobile/board-lager.c             |  2 +-
 arch/arm/mach-shmobile/include/mach/r8a73a4.h    |  2 +-
 arch/arm/mach-shmobile/include/mach/r8a7790.h    |  2 +-
 arch/arm/mach-shmobile/setup-r8a73a4.c           |  4 ++--
 arch/arm/mach-shmobile/setup-r8a7790.c           | 25 ++++++++++++------------
 8 files changed, 21 insertions(+), 20 deletions(-)
