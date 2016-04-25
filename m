From: robh@kernel.org (Rob Herring)
Date: Mon, 25 Apr 2016 08:49:46 -0500
Subject: [PATCH 11/41] Documentation: dt: dma: fix spelling mistake
In-Reply-To: <1461543878-3639-12-git-send-email-eric@engestrom.ch>
References: <1461543878-3639-1-git-send-email-eric@engestrom.ch>
 <1461543878-3639-12-git-send-email-eric@engestrom.ch>
Message-ID: <20160425134946.GA8322@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 25, 2016 at 01:24:08AM +0100, Eric Engestrom wrote:
> Signed-off-by: Eric Engestrom <eric@engestrom.ch>

Applied, thanks.

Rob

> ---
>  Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
> index 2291c40..3cf0072d 100644
> --- a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
> +++ b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
> @@ -7,7 +7,7 @@ Required properties:
>  - compatible: Should be "xlnx,axi-dma-1.00.a"
>  - #dma-cells: Should be <1>, see "dmas" property below
>  - reg: Should contain DMA registers location and length.
> -- dma-channel child node: Should have atleast one channel and can have upto
> +- dma-channel child node: Should have at least one channel and can have up to
>  	two channels per device. This node specifies the properties of each
>  	DMA channel (see child node properties below).
>  
> -- 
> 2.8.0
> 
