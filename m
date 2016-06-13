From: robh@kernel.org (Rob Herring)
Date: Mon, 13 Jun 2016 13:59:08 -0500
Subject: [PATCH 3/4] Documentation: DT: dma: Delete binding doc for AXI DMA
In-Reply-To: <1465549954-30220-4-git-send-email-appanad@xilinx.com>
References: <1465549954-30220-1-git-send-email-appanad@xilinx.com>
 <1465549954-30220-4-git-send-email-appanad@xilinx.com>
Message-ID: <20160613185908.GA26187@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 10, 2016 at 02:42:33PM +0530, Kedareswara rao Appana wrote:
> The AXI DMA support is added to the existing AXI VDMA
> driver. Device tree binding information also updated
> in the VDMA binding doc.
> 
> Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
> ---
>  .../devicetree/bindings/dma/xilinx/xilinx_dma.txt  |   65 --------------------
>  1 files changed, 0 insertions(+), 65 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt

Acked-by: Rob Herring <robh@kernel.org>
