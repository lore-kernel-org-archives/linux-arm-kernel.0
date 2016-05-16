From: robh@kernel.org (Rob Herring)
Date: Mon, 16 May 2016 11:22:05 -0500
Subject: [PATCH v9 1/2] Documentation: DT: dma: Add Xilinx zynqmp dma
 device tree binding documentation
In-Reply-To: <1463123033-5443-1-git-send-email-appanad@xilinx.com>
References: <1463123033-5443-1-git-send-email-appanad@xilinx.com>
Message-ID: <20160516162205.GA11930@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 13, 2016 at 12:33:52PM +0530, Kedareswara rao Appana wrote:
> Device-tree binding documentation for Xilinx zynqmp dma engine
> used in Zynq UltraScale+ MPSoC.
> 
> Signed-off-by: Punnaiah Choudary Kalluri <punnaia@xilinx.com>
> Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
> ---
> Changs in v9:
> - Removed include sg runtime configuration parameter
>   from the binding doc as suggested by Lars.
> Changes in v8:
> - Removed all the software runtime configuration parameters
>   from the binding doc as suggested by the Lars.
> Changes in v7:
> - None.
> Changes in v6:
> - Removed desc-axi-cache/dst-axi-cache/src-axi-cache properties
>   from the binding doc as it allow broken combinations when dma-coherent
>   is set as suggested by Rob.
> - Fixed minor comments given by Rob related coding(lower case DT node name).
> Changes in v5:
> - Use dma-coherent flag for coherent transfers as suggested by rob.
> - Removed unnecessary properties from binding doc as suggested by Rob.
> Changes in v4:
> - None
> Changes in v3:
> - None
> Changes in v2:
> - None.
> 
>  .../devicetree/bindings/dma/xilinx/zynqmp_dma.txt  | 27 ++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/xilinx/zynqmp_dma.txt

Acked-by: Rob Herring <robh@kernel.org>
