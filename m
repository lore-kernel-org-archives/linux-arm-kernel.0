From: ck.hu@mediatek.com (CK Hu)
Date: Wed, 23 May 2018 11:30:58 +0800
Subject: [PATCH v2 1/4] drm/mediatek: update dt-bindings for mt2712
In-Reply-To: <20180523022517.12103-2-stu.hsieh@mediatek.com>
References: <20180523022517.12103-1-stu.hsieh@mediatek.com>
 <20180523022517.12103-2-stu.hsieh@mediatek.com>
Message-ID: <1527046258.2655.1.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Stu:

On Wed, 2018-05-23 at 10:25 +0800, Stu Hsieh wrote:
> Update device tree binding documentation for the display subsystem for
> Mediatek MT2712 SoCs.
> 

Acked-by: CK Hu <ck.hu@mediatek.com>

> Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
> ---
>  Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
> index 383183a89164..8469de510001 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
> @@ -40,7 +40,7 @@ Required properties (all function blocks):
>  	"mediatek,<chip>-dpi"        - DPI controller, see mediatek,dpi.txt
>  	"mediatek,<chip>-disp-mutex" - display mutex
>  	"mediatek,<chip>-disp-od"    - overdrive
> -  the supported chips are mt2701 and mt8173.
> +  the supported chips are mt2701, mt2712 and mt8173.
>  - reg: Physical base address and length of the function block register space
>  - interrupts: The interrupt signal from the function block (required, except for
>    merge and split function blocks).
