From: robh@kernel.org (Rob Herring)
Date: Fri, 20 Nov 2015 08:20:13 -0600
Subject: [PATCH 2/4] spi: mediatek: remove unrequired description
In-Reply-To: <1447986080-31410-2-git-send-email-leilk.liu@mediatek.com>
References: <1447986080-31410-1-git-send-email-leilk.liu@mediatek.com>
 <1447986080-31410-2-git-send-email-leilk.liu@mediatek.com>
Message-ID: <20151120142013.GA498@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 20, 2015 at 10:21:17AM +0800, Leilk Liu wrote:
> cs-gpios isn't required with patch "spi: mediatek: single
> device does not require cs_gpios", so modify the description.
> 
> Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>

This could use a better subject. Try to make subjects specific enough 
they would only ever apply to the change.

Acked-by: Rob Herring <robh@kernel.org>

> ---
>  .../devicetree/bindings/spi/spi-mt65xx.txt         |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-mt65xx.txt b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
> index fba8334..60a183c 100644
> --- a/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
> +++ b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
> @@ -29,7 +29,7 @@ Required properties:
>    muxes clock, and "spi-clk" for the clock gate.
>  
>  Optional properties:
> --cs-gpios: see spi-bus.txt, only required for MT8173.
> +-cs-gpios: see spi-bus.txt.
>  
>  - mediatek,pad-select: specify which pins group(ck/mi/mo/cs) spi
>    controller used. This is an array, the element value should be 0~3,
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
