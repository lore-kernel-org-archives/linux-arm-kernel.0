From: horms+renesas@verge.net.au (Simon Horman)
Date: Sat, 23 Aug 2014 10:43:35 +0900
Subject: [GIT PULL] Renesas ARM Based SoC Boards Updates for v3.18
Message-ID: <cover.1408671094.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC boards updates for v3.18.


The following changes since commit 7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9:

  Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-boards-for-v3.18

for you to fetch changes up to 3969d6490ba35b01f84bb12472c29c6029f7298b:

  ARM: shmobile: kzm9g-reference: Remove unneeded nr_irqs initialization (2014-08-20 09:06:37 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC Boards Updates for v3.18

* Remove unnecessary nr_irqs initialisation on kzm9g and marzen
* Use shmobile_init_delay and shmobile_init_late on a wider
  range of boards

----------------------------------------------------------------
Geert Uytterhoeven (2):
      ARM: shmobile: kzm9g: Remove unneeded nr_irqs initialization
      ARM: shmobile: kzm9g-reference: Remove unneeded nr_irqs initialization

Magnus Damm (6):
      ARM: shmobile: kzm9g: Add shmobile_init_late()
      ARM: shmobile: marzen: Add shmobile_init_late()
      ARM: shmobile: bockw: Add shmobile_init_late()
      ARM: shmobile: ape6evm: Add shmobile_init_late()
      ARM: shmobile: ape6evm: Use shmobile_init_delay()
      ARM: shmobile: marzen: Remove NR_IRQS_LEGACY

 arch/arm/mach-shmobile/board-ape6evm-reference.c | 3 ++-
 arch/arm/mach-shmobile/board-ape6evm.c           | 3 ++-
 arch/arm/mach-shmobile/board-bockw-reference.c   | 1 +
 arch/arm/mach-shmobile/board-kzm9g-reference.c   | 2 +-
 arch/arm/mach-shmobile/board-kzm9g.c             | 1 -
 arch/arm/mach-shmobile/board-marzen-reference.c  | 2 +-
 6 files changed, 7 insertions(+), 5 deletions(-)
