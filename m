From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 20 May 2013 15:55:45 -0400
Subject: [GIT PULL] ARM: mvebu: cleanup for v3.11 (round 2)
Message-ID: <20130520195545.GI31290@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The following changes since commit 49ed97f751bfaea133ae5c44f1247db09b9ca144:

  ARM: Orion: Remove redundant init_dma_coherent_pool_size() (2013-05-13 19:35:39 +0000)

are available in the git repository at:

  git://git.infradead.org/users/jcooper/linux.git tags/cleanup-3.11-2

for you to fetch changes up to 84f013bc3a2e36365abff9416714e34c2993a4a5:

  ARM: mvebu: Remove init_irq declaration in machine description (2013-05-19 20:15:56 +0000)

----------------------------------------------------------------
mvebu cleanup for v3.11 (round 2)

 - mvebu: remove init_irq decl in machine desc.

----------------------------------------------------------------
Maxime Ripard (1):
      ARM: mvebu: Remove init_irq declaration in machine description

 arch/arm/mach-mvebu/armada-370-xp.c | 2 --
 1 file changed, 2 deletions(-)
