From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 30 Dec 2013 09:57:05 +0900
Subject: [GIT PULL 0/3] Third Round of Renesas ARM based SoC Fixes for v3.13
Message-ID: <cover.1388364591.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider this third round of Renesas ARM based SoC fixes for v3.13.
Or alternatively, if it is too late in the v3.13 cycle, please consider
them for v3.14.

This pull request is based on the second round such fixes,
tagged as renesas-fixes2-for-v3.13, which you have already pulled.


The following changes since commit d721a15c300c5f638a11573a6dd492158e737d6a:

  ARM: shmobile: r8a7790: fix shdi resource sizes (2013-12-19 18:14:48 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-fixes3-for-v3.13

for you to fetch changes up to b6328a6b7ba57fc84c38248f6f0e387e1170f1a8:

  ARM: shmobile: mackerel: Fix coherent DMA mask (2013-12-26 14:21:03 +0900)

----------------------------------------------------------------
Third Round of Renesas ARM based SoC Fixes for v3.13

* sh7372 (SH-Mobile AP4) based Mackerel board
  r8a773a0 (SH-Mobile AG5) based kzm9g board
  r8a7740 (R-Mobile A1) based Armadillo board

  - Correct coherent DMA mask

    This resolves regressions introduced by 4dcfa60071b3d23f
    ("ARM: DMA-API: better handing of DMA masks for coherent allocations")
    in v3.12-rc1.

----------------------------------------------------------------
Laurent Pinchart (3):
      ARM: shmobile: armadillo: Fix coherent DMA mask
      ARM: shmobile: kzm9g: Fix coherent DMA mask
      ARM: shmobile: mackerel: Fix coherent DMA mask

 arch/arm/mach-shmobile/board-armadillo800eva.c | 4 ++--
 arch/arm/mach-shmobile/board-kzm9g.c           | 2 +-
 arch/arm/mach-shmobile/board-mackerel.c        | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)
