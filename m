From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 13 May 2013 16:25:29 -0400
Subject: [GIT PULL] ARM: mvebu: cleanups for v3.11 (round 1)
Message-ID: <20130513202529.GD31290@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The following changes since commit f722406faae2d073cc1d01063d1123c35425939e:

  Linux 3.10-rc1 (2013-05-11 17:14:08 -0700)

are available in the git repository at:

  git://git.infradead.org/users/jcooper/linux.git tags/cleanup-3.11-1

for you to fetch changes up to 49ed97f751bfaea133ae5c44f1247db09b9ca144:

  ARM: Orion: Remove redundant init_dma_coherent_pool_size() (2013-05-13 19:35:39 +0000)

----------------------------------------------------------------
mvebu cleanup for v3.11 (round 1)

 - orion5x/kirkwood/mvebu
    - remove init_dma_coherent_pool_size() as it's no longer needed

----------------------------------------------------------------
Andrew Lunn (1):
      ARM: Orion: Remove redundant init_dma_coherent_pool_size()

 arch/arm/mach-kirkwood/common.c     | 6 ------
 arch/arm/mach-mvebu/armada-370-xp.c | 7 -------
 arch/arm/mach-orion5x/common.c      | 7 -------
 3 files changed, 20 deletions(-)
