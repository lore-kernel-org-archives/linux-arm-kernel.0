From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 25 Aug 2014 10:09:40 +0900
Subject: [GIT PULL] Renesas ARM Based SoC Boards Cleanups For v3.18
Message-ID: <cover.1408927475.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC boards cleanups for v3.18.


The following changes since commit 7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9:

  Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-boards-cleanups-for-v3.18

for you to fetch changes up to 0e56d75395f98a659e6879708bbd9328d2ce347e:

  ARM: shmobile: armadillo800eva: Sort includes (2014-08-22 10:46:54 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC Boards Cleanups For v3.18

* Sort armadillo800eva includes

----------------------------------------------------------------
Simon Horman (2):
      ARM: shmobile: armadillo800eva-reference: Sort includes
      ARM: shmobile: armadillo800eva: Sort includes

 .../board-armadillo800eva-reference.c              |  2 +-
 arch/arm/mach-shmobile/board-armadillo800eva.c     | 40 +++++++++++-----------
 2 files changed, 21 insertions(+), 21 deletions(-)
