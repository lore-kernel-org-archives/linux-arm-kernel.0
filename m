From: robh@kernel.org (Rob Herring)
Date: Fri, 20 Nov 2015 08:17:25 -0600
Subject: [PATCH 1/4] spi: mediatek: update document devicetree bindings
 to fix syntax error
In-Reply-To: <1447986080-31410-1-git-send-email-leilk.liu@mediatek.com>
References: <1447986080-31410-1-git-send-email-leilk.liu@mediatek.com>
Message-ID: <20151120141725.GA31912@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 20, 2015 at 10:21:16AM +0800, Leilk Liu wrote:
> This patch updates document devicetree bindings
> to fix syntax error.
> 
> Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>

Acked-by: Rob Herring <robh@kernel.org>

> ---
>  .../devicetree/bindings/spi/spi-mt65xx.txt         |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-mt65xx.txt b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
> index ce363c923f..fba8334 100644
> --- a/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
> +++ b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
> @@ -32,7 +32,7 @@ Optional properties:
>  -cs-gpios: see spi-bus.txt, only required for MT8173.
>  
>  - mediatek,pad-select: specify which pins group(ck/mi/mo/cs) spi
> -  controller used. This is a array, the element value should be 0~3,
> +  controller used. This is an array, the element value should be 0~3,
>    only required for MT8173.
>      0: specify GPIO69,70,71,72 for spi pins.
>      1: specify GPIO102,103,104,105 for spi pins.
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
