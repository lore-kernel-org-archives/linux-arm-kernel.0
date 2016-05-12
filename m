From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 12 May 2016 11:59:58 +0530
Subject: [PATCH v4 0/5] dmaengine: vdma: AXI DMA's enhancments
In-Reply-To: <1460006985-14805-1-git-send-email-appanad@xilinx.com>
References: <1460006985-14805-1-git-send-email-appanad@xilinx.com>
Message-ID: <20160512062957.GA2274@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 07, 2016 at 10:59:40AM +0530, Kedareswara rao Appana wrote:
> This patch series does some enhancments to the VDMA driver
> which includes
> --> Adding support for AXI DMA IP.
> --> Adding support for AXI CDMA IP.

Applied all, thanks

> 
> Kedareswara rao Appana (5):
>   dmaengine: vdma: Rename xilinx_vdma_ prefix to xilinx_dma
>   Documentation: DT: vdma: update binding doc for AXI DMA
>   dmaengine: vdma: Add Support for Xilinx AXI Direct Memory Access
>     Engine
>   Documentation: DT: vdma: update binding doc for AXI CDMA
>   dmaengine: vdma: Add Support for Xilinx AXI Central Direct Memory
>     Access Engine
> 
>  .../devicetree/bindings/dma/xilinx/xilinx_vdma.txt |   17 +-
>  drivers/dma/xilinx/xilinx_vdma.c                   | 1326 ++++++++++++++------
>  include/linux/dma/xilinx_dma.h                     |   14 +
>  3 files changed, 1003 insertions(+), 354 deletions(-)
> 
> -- 
> 2.1.2
> 

-- 
~Vinod
