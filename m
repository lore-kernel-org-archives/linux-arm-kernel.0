From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  7 Aug 2013 13:36:37 +0900
Subject: [GIT PULL 0/2] Renesas ARM based SoC boards cleanups for v3.12
Message-ID: <cover.1375842006.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Arnd,

please consider these Renesas ARM based SoC boards cleanups for v3.12.

This pull-request is based on renesas-boards-for-v3.12,
which I have previously sent a pull-request for.

I have separated these cleanups from those that I included
in renesas-cleanup3-for-v3.12 as there are different dependencies
involved and this approach seemed simpler somehow.


The following changes since commit f79d68da510bf1b95beff4d556b78d06801f11dc:

  ARM: shmobile: ape6evm: add SDHI interfaces (2013-07-25 14:46:38 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-boards-cleanup-for-v3.12

for you to fetch changes up to 8c8881b50691e17864cc54e5824b140e62fc2035:

  ARM: shmobile: lager: add missing __initdata (2013-08-06 09:53:56 +0900)

----------------------------------------------------------------
Renesas ARM based SoC boards cleanups for v3.12

* Add __initdata annotations to lager board
* Add __initconst annotations to ape6evm board

----------------------------------------------------------------
Guennadi Liakhovetski (1):
      ARM: shmobile: ape6evm: add "__initconst" annotations where needed

Kuninori Morimoto (1):
      ARM: shmobile: lager: add missing __initdata

 arch/arm/mach-shmobile/board-ape6evm.c | 18 +++++++++---------
 arch/arm/mach-shmobile/board-lager.c   |  4 ++--
 2 files changed, 11 insertions(+), 11 deletions(-)
