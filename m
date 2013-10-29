From: mpa@pengutronix.de (Markus Pargmann)
Date: Tue, 29 Oct 2013 08:47:44 +0100
Subject: [PATCH v5 0/5] dma: mxs-dma bugfixes and cleanup
Message-ID: <1383032869-12863-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

v5 is rebased onto your dma_complete branch. It includes one bugfix.

This series contains a number of bugfixes for the mxs DMA engine.

Regards,

Markus Pargmann


Markus Pargmann (5):
  dma: mxs-dma: Cleanup interrupt handler
  dma: mxs-dma: Report correct residue for cyclic DMA
  dma: mxs-dma: Fix channel reset hardware bug
  dma: mxs-dma: Update state after channel reset
  dma: mxs-dma: Use semaphores for cyclic DMA

 drivers/dma/mxs-dma.c | 176 +++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 137 insertions(+), 39 deletions(-)

-- 
1.8.4.rc3
