From: zonque@gmail.com (Daniel Mack)
Date: Fri, 16 Aug 2013 19:05:03 +0200
Subject: [PATCH v4 0/4] dma: pdma: cyclic, residue, DMA_PRIVATE
Message-ID: <1376672707-24527-1-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here's another spin of my pending patches for mmp_pdma. It has grown
by two more patches now, and they address the issues pointed out by
Chao Xie and Xiang Wang.

I'd appreciate another round of reviews.


Thanks,
Daniel

Daniel Mack (4):
  dma: mmp_pdma: only complete one transaction from dma_do_tasklet()
  dma: mmp_pdma: add support for cyclic DMA descriptors
  dma: mmp_pdma: add support for residue reporting
  dma: mmp_pdma: set DMA_PRIVATE

 drivers/dma/mmp_pdma.c | 225 +++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 208 insertions(+), 17 deletions(-)

-- 
1.8.3.1
