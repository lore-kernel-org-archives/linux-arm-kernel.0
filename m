From: robh@kernel.org (Rob Herring)
Date: Tue, 28 Jun 2016 15:55:24 -0500
Subject: [PATCH v2 5/5] dmaengine: dma: Use different channel names for
 each dma
In-Reply-To: <1466745686-23898-6-git-send-email-appanad@xilinx.com>
References: <1466745686-23898-1-git-send-email-appanad@xilinx.com>
 <1466745686-23898-6-git-send-email-appanad@xilinx.com>
Message-ID: <20160628205524.GG3737@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 24, 2016 at 10:51:26AM +0530, Kedareswara rao Appana wrote:
> Current driver assumes that child node channel name is either
> "xlnx,axi-vdma-mm2s-channel" or "xlnx,axi-vdma-s2mm-channel"
> which is confusing the users of AXI DMA and CDMA.
> This patch fixes this issue by using different channel
> names for the AXI DMA and AXI CDMA child nodes.
> 
> Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
> ---
> Chanes for v2:
> ---> New patch.
> 
>  .../devicetree/bindings/dma/xilinx/xilinx_dma.txt  |    6 +++++-
>  drivers/dma/xilinx/xilinx_dma.c                    |    8 ++++++--
>  2 files changed, 11 insertions(+), 3 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
