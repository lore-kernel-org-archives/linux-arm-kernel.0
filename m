From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 28 May 2013 14:34:22 -0400
Subject: [GIT PULL] ARM: mvebu: cleanup for v3.11 (round 3 cumulative)
Message-ID: <20130528183422.GA31290@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof,

This is the latest for cleanup, and the summary includes everything so
far for this window.


The following changes since commit f722406faae2d073cc1d01063d1123c35425939e:

  Linux 3.10-rc1 (2013-05-11 17:14:08 -0700)

are available in the git repository at:

  git://git.infradead.org/users/jcooper/linux.git tags/cleanup-3.11-3

for you to fetch changes up to c589f9b4b51317cfc530812fe90a9895bd51430e:

  arm: mvebu: mark functions of armada-370-xp.c as static (2013-05-21 13:44:32 +0000)

----------------------------------------------------------------
mvebu cleanup for v3.11 (round 3)

 - mvebu
    - mark functions in armada-370-xp.c as static

----------------------------------------------------------------
Andrew Lunn (1):
      ARM: Orion: Remove redundant init_dma_coherent_pool_size()

Maxime Ripard (1):
      ARM: mvebu: Remove init_irq declaration in machine description

Thomas Petazzoni (1):
      arm: mvebu: mark functions of armada-370-xp.c as static

 arch/arm/mach-kirkwood/common.c     |  6 ------
 arch/arm/mach-mvebu/armada-370-xp.c | 15 +++------------
 arch/arm/mach-orion5x/common.c      |  7 -------
 3 files changed, 3 insertions(+), 25 deletions(-)
