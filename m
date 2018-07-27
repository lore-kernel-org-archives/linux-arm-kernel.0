From: radhey.shyam.pandey@xilinx.com (Radhey Shyam Pandey)
Date: Fri, 27 Jul 2018 16:20:36 +0530
Subject: [PATCH 0/3] dmaengine: xilinx_dma: Minor fix and refactoring
Message-ID: <1532688639-32230-1-git-send-email-radhey.shyam.pandey@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset fixes 64-bit simple CDMA transfer.
It also does some trivial code refactoring.


Radhey Shyam Pandey (3):
  dmaengine: xilinx_dma: Refactor axidma channel allocation
  dmaengine: xilinx_dma: Refactor axidma channel validation
  dmaengine: xilinx_dma: Fix 64-bit simple CDMA transfer

 drivers/dma/xilinx/xilinx_dma.c |   46 ++++++++++++++++++++------------------
 1 files changed, 24 insertions(+), 22 deletions(-)
