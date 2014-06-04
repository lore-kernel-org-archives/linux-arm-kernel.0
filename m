From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 04 Jun 2014 13:25:20 +0200
Subject: [PATCH v2 2/7] DMA: shdma: Spelling s/controll/control/
In-Reply-To: <1401716531-29794-3-git-send-email-geert+renesas@glider.be>
References: <1401716531-29794-1-git-send-email-geert+renesas@glider.be>
 <1401716531-29794-3-git-send-email-geert+renesas@glider.be>
Message-ID: <5393917.echhd9vGYd@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

Thank you for the patch.

On Monday 02 June 2014 15:42:06 Geert Uytterhoeven wrote:
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> v2:
>   - New
> 
>  Documentation/devicetree/bindings/dma/shdma.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/shdma.txt
> b/Documentation/devicetree/bindings/dma/shdma.txt index
> d26b7065ae94..2b61cab0525c 100644
> --- a/Documentation/devicetree/bindings/dma/shdma.txt
> +++ b/Documentation/devicetree/bindings/dma/shdma.txt
> @@ -73,7 +73,7 @@ Example:
>  	};
> 
>  For r8a7790 and newer implementations, the information for the channel
> -controll register is found in the dma phandle and #dma-cells is set to 2.
> +control register is found in the dma phandle and #dma-cells is set to 2.
> 
>  	dma0: dma-mux at 0 {
>  		compatible = "renesas,shdma-mux";

-- 
Regards,

Laurent Pinchart
