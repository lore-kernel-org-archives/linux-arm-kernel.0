From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Tue, 10 Mar 2015 17:01:26 -0700
Subject: [PATCH] dma: Add Xilinx ZDMA device tree Binding Documentation
In-Reply-To: <BN1AFFO11FD032F933FA09686353911532C8180@BN1AFFO11FD032.protection.gbl>
References: <BN1AFFO11FD032F933FA09686353911532C8180@BN1AFFO11FD032.protection.gbl>
Message-ID: <BN1BFFO11FD01214F9392FD94A0D30D9E28C190@BN1BFFO11FD012.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-03-10 at 07:46PM +0530, Punnaiah Choudary Kalluri wrote:
> Device-tree binding documentation for Xilinx ZDMA Engine
> 
> Signed-off-by: Punnaiah Choudary Kalluri <punnaia@xilinx.com>
> ---
>  .../devicetree/bindings/dma/xilinx/zdma.txt        |   76 ++++++++++++++++++++
>  1 files changed, 76 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/dma/xilinx/zdma.txt
> 
> diff --git a/Documentation/devicetree/bindings/dma/xilinx/zdma.txt b/Documentation/devicetree/bindings/dma/xilinx/zdma.txt
> new file mode 100644
> index 0000000..399a3bc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/xilinx/zdma.txt
> @@ -0,0 +1,76 @@
> +Xilinx ZDMA engine, it does support memory to memory transfers,
> +memory to device and device to memory transfers. It also has flow
> +control and rate control support for slave/peripheral dma access.
> +
> +Xilinx ZynqMP has two instances of general purpose DMA(ZDMA).
> +one is located in FPD(full power domain) and other is located in
> +LPD(low power domain).
> +
> +ZDMA instance located in FPD is referred as FPDMA and instance located
> +in LPD is referred as LPDMA.
> +
> +FPDMA is configured with 8 DMA channels and AXI bus width is 128 byte.
> +LPDMA is configured with 8 DMA channels and AXI bus width is 64 byte.

All these implementation details are good background information, but
shouldn't be part of the binding.

	S?ren
