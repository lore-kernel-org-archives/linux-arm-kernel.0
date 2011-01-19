From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 20 Jan 2011 05:50:34 +0800
Subject: [PATCH 0/6] A few fixes on imx-sdma
Message-ID: <1295473840-17295-1-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch set is to address the concerns discussed on thread below.
And it's been tested on mx51 babbage board with sound driver.

"A few questions on imx-sdma"
http://article.gmane.org/gmane.linux.ports.arm.kernel/103001/

Shawn Guo (6)
 drivers/dma/imx-sdma.c |   31 +++++++++++++++++++------------
 1 files changed, 19 insertions(+), 12 deletions(-)

 [PATCH 1/6] dmaengine: imx-sdma: remove IMX_DMA_SG_LOOP handling in sdma_prep_slave_sg()
 [PATCH 2/6] dmaengine: imx-sdma: set sdmac->status to DMA_ERROR in err_out of sdma_prep_slave_sg()
 [PATCH 3/6] dmaengine: imx-sdma: return sdmac->status in sdma_tx_status()
 [PATCH 4/6] dmaengine: imxs-sdma: correct sdmac->status in sdma_handle_channel_loop()
 [PATCH 5/6] dmaengine: imx-sdma: fix up param for the last BD in sdma_prep_slave_sg()
 [PATCH 6/6] dmaengine: imx-sdma: avoid stopping channel in the middle of a BD transfer

Regards,
Shawn
