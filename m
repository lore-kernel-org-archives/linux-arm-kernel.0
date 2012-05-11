From: rmallon@gmail.com (Ryan Mallon)
Date: Fri, 11 May 2012 11:03:04 +1000
Subject: [GIT PULL] ep93xx fixes for 3.5
Message-ID: <4FAC6548.5060008@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 0034102808e0dbbf3a2394b82b1bb40b5778de9e:

  Linux 3.4-rc2 (2012-04-07 18:30:41 -0700)

are available in the git repository at:

  git://github.com/RyanMallon/linux-ep93xx.git tags/ep93xx-fixes-for-3.5

for you to fetch changes up to 2b3c83efc9a653af6a24799eeb1a2900ba0439e6:

  dmaengine/ep93xx_dma: Implement double buffering for M2M DMA channels (2012-04-20 08:37:19 +1000)

----------------------------------------------------------------
Rafal Prylowski (2):
      arm: ep93xx: Don't try to release not acquired GPIO lines
      dmaengine/ep93xx_dma: Implement double buffering for M2M DMA channels

 arch/arm/mach-ep93xx/core.c |    2 +-
 drivers/dma/ep93xx_dma.c    |  117 ++++++++++++++++++++++++++++++++++---------
 2 files changed, 94 insertions(+), 25 deletions(-)
