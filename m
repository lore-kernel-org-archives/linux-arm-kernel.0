From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 25 Jun 2014 16:35:34 +0900
Subject: [GIT PULL] Renesas ARM Based SoC Boards Updates for v3.17
Message-ID: <cover.1403681531.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC boards updates for v3.17.

This pull request is based on commits included in 'Renesas ARM Based SoC
Updates for v3.17", which is tagged as renesas-soc-for-v3.17 and I have
sent a pull-request for.  That pull requests includes a few extra commits
which were added after the board code was added on top.


The following changes since commit ecdaca48629bd99609fdc612685363330967dce2:

  ARM: shmobile: rcar-gen2: correct return value of shmobile_smp_apmu_suspend_init (2014-06-17 19:33:22 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git renesas-boards-for-v3.17

for you to fetch changes up to 5f65c5bd58bf027eb2bacc2294a98e7aea81c630:

  ARM: shmobile: Enable R-Car Gen2 CMA code in board files (2014-06-17 19:35:59 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC Boards Updates for v3.17

* armadillo800eva LED support
* Remove now unnecessary work arounds for c\lock issues
* Enable R-Car Gen2 CMA code

----------------------------------------------------------------
Geert Uytterhoeven (4):
      ARM: shmobile: koelsch-reference: Remove workarounds for core clock issues
      ARM: shmobile: lager-reference: Remove workarounds for core clock issues
      ARM: shmobile: armadillo800eva legacy: Add LED support
      ARM: shmobile: armadillo800eva reference: Spelling s/ED/LED/

Magnus Damm (1):
      ARM: shmobile: Enable R-Car Gen2 CMA code in board files

 .../board-armadillo800eva-reference.c              |  8 ++---
 arch/arm/mach-shmobile/board-armadillo800eva.c     | 35 ++++++++++++++++++++++
 arch/arm/mach-shmobile/board-koelsch-reference.c   | 16 +---------
 arch/arm/mach-shmobile/board-koelsch.c             |  1 +
 arch/arm/mach-shmobile/board-lager-reference.c     | 15 +---------
 arch/arm/mach-shmobile/board-lager.c               |  1 +
 6 files changed, 43 insertions(+), 33 deletions(-)
