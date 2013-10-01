From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  1 Oct 2013 11:28:01 +0900
Subject: [GIT PULL 0/3] Renesas ARM based SoC cleanups for v3.13
Message-ID: <cover.1380523393.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin, Olof and Arnd,

please consider these Renesas ARM based SoC cleanups for v3.13.

This pull request is based on v3.12-rc1.


The following changes since commit 272b98c6455f00884f0350f775c5342358ebb73f:

  Linux 3.12-rc1 (2013-09-16 16:17:51 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-cleanup-for-v3.13

for you to fetch changes up to cde214a890f81797a5eee94fffc89c1de21ed991:

  ARM: shmobile: r8a7790: Constify platform data and resources (2013-09-19 14:33:44 -0700)

----------------------------------------------------------------
Renesas ARM based SoC cleanups for v3.13

* Constify platform data and resources of r8a7790 SoC
* Rename to r8a7790_init_delay() as r8a7790_init_early()
  - This is in preparation for doing more than just initialising the delay
* Rename r8a73a4_init_delay() as r8a73a4_init_early()
  - This is in preparation for doing more than just initialising the delay

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
