From: radhey.shyam.pandey@xilinx.com (Radhey Shyam Pandey)
Date: Wed, 13 Jun 2018 13:04:46 +0530
Subject: [PATCH 0/2] Enable VDMA S2MM vertical flip support
Message-ID: <1528875288-9140-1-git-send-email-radhey.shyam.pandey@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The AXI VDMA core supports Vertical Flip with S2MM as the path when
Enable Vertical Flip (Advanced tab) is selected. This patch series add
DT property for vertical flip and program its state in VDMA start_transfer.

Radhey Shyam Pandey (2):
  dt-bindings: dmaengine: xilinx_dma: Add VDMA vertical flip property
  dmaengine: xilinx_dma: Enable VDMA S2MM vertical flip support

 .../devicetree/bindings/dma/xilinx/xilinx_dma.txt  |    2 +
 drivers/dma/xilinx/xilinx_dma.c                    |   22 ++++++++++++++++++++
 include/linux/dma/xilinx_dma.h                     |    2 +
 3 files changed, 26 insertions(+), 0 deletions(-)
