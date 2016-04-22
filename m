From: robh@kernel.org (Rob Herring)
Date: Fri, 22 Apr 2016 15:34:56 -0500
Subject: [PATCH v4 2/3] Documentation: DT: vdma: Add clock support for dmas
In-Reply-To: <1461305630-4826-3-git-send-email-appanad@xilinx.com>
References: <1461305630-4826-1-git-send-email-appanad@xilinx.com>
 <1461305630-4826-3-git-send-email-appanad@xilinx.com>
Message-ID: <20160422203456.GA15238@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 22, 2016 at 11:43:49AM +0530, Kedareswara rao Appana wrote:
> This patch updates the binding doc with clock description
> for AXI DMA's.
> 
> Acked-by: S?ren Brinkmann <soren.brinkmann@xilinx.com>
> Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
> ---
> Changes for v4:
> ---> None.
> Changes for v3:
> ---> Added clock support for all the AXI DMA's.
> Changes for v2:
> --> Listed down all the clocks supported by the h/w
>     as suggested by the Datta.
> --> Used IP clock names instead of shortcut clock name
> 
>  .../devicetree/bindings/dma/xilinx/xilinx_vdma.txt        | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
