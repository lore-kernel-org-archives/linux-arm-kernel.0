From: javier.martin@vista-silicon.com (Javier Martin)
Date: Thu, 22 Mar 2012 14:54:00 +0100
Subject: [PATCH v4 00/15] dmaengine: imx-dma: rebase of features for 3.4.
Message-ID: <1332424455-15594-1-git-send-email-javier.martin@vista-silicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, 
as requested by Vinod yesterday, this is a rebase onto 'next' branch of 
all imx-dma pending changes for 3.4.

It is utterly important for us that these changes make into mainline 
for 3.4. 

I will be out of the office until next Monday so please Vinod, if you 
see any minor issue could you just merge it so that I can send a small
fix next week in order not to miss the merge window?

[PATCH v4 01/15] dmaengine: imx-dma: merge old dma-v1.c with imx-dma.c
[PATCH v4 02/15] dmaengine: imx-dma: remove data member from internal structure.
[PATCH v4 03/15] dmaengine: imx-dma: remove dma_mode member of internal structure.
[PATCH v4 04/15] dmaengine: imx-dma: remove 'imxdma_setup_mem2mem_hw' function.
[PATCH v4 05/15] dmaengine: imx-dma: remove 'imxdma_config_channel_hw' function.
[PATCH v4 06/15] dmaengine: imx-dma: remove 'imxdma_setup_sg_hw' function.
[PATCH v4 07/15] dmaengine: imx-dma: remove sg member from internal structure.
[PATCH v4 08/15] dmaengine: imx-dma: remove 'in_use' field of 'internal' structure.
[PATCH v4 09/15] dmaengine: imx-dma: remove 'resbytes' field of 'internal' structure.
[PATCH v4 10/15] dmaengine: imx-dma: remove internal structure.
[PATCH v4 11/15] dmaengine: imx-dma: remove unused arg of imxdma_sg_next.
[PATCH v4 12/15] dmaengine: imx-dma: remove 'imx_dmav1_baseaddr' and 'dma_clk'.
[PATCH v4 13/15] dmaengine: imx-dma: use 'dev_dbg' and 'dev_warn' for messages.
[PATCH v4 14/15] dmaengine: i.MX: Add support for interleaved transfers.
[PATCH v4 15/15] dmaengine: i.MX: Fix merge of cookie branch.
