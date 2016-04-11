From: robh@kernel.org (Rob Herring)
Date: Mon, 11 Apr 2016 08:59:36 -0500
Subject: [PATCH v4 2/5] Documentation: DT: vdma: update binding doc for
 AXI DMA
In-Reply-To: <1460006985-14805-3-git-send-email-appanad@xilinx.com>
References: <1460006985-14805-1-git-send-email-appanad@xilinx.com>
 <1460006985-14805-3-git-send-email-appanad@xilinx.com>
Message-ID: <20160411135936.GA32212@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 07, 2016 at 10:59:42AM +0530, Kedareswara rao Appana wrote:
> This patch updates the device-tree binding doc for
> adding support for AXI DMA.
> Also this patch differentiates required properties b/w
> DMA and VDMA.
> 
> Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
> ---
> Changes for v4:
> ---> None.
> Changes for v3:
> ---> Removed AXI DMA DT example from the patch as suggested by Rob.
> ---> Differentiated required/optional properties for each DMA's
>      as suggested by Rob.
> Changes for v2:
> ---> Modified commit message as suggested by Vinod.
> ---> Moved the patch to forward in the series as suggested by vinod.
> 
>  .../devicetree/bindings/dma/xilinx/xilinx_vdma.txt          | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
