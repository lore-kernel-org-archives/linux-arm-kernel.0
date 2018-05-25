From: ck.hu@mediatek.com (CK Hu)
Date: Fri, 25 May 2018 11:18:12 +0800
Subject: [PATCH v3 1/8] drm/mediatek: update dt-bindings for mt2712
In-Reply-To: <1527215665-11937-2-git-send-email-stu.hsieh@mediatek.com>
References: <1527215665-11937-1-git-send-email-stu.hsieh@mediatek.com>
 <1527215665-11937-2-git-send-email-stu.hsieh@mediatek.com>
Message-ID: <1527218292.27165.2.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Stu:

On Fri, 2018-05-25 at 10:34 +0800, stu.hsieh at mediatek.com wrote:
> From: Stu Hsieh <stu.hsieh@mediatek.com>
> 
> Update device tree binding documentation for the display subsystem for
> Mediatek MT2712 SoCs.
> 

I've acked v2 of this patch and v3 is the same as v2, so you should keep
my ack in commit message.

Regards,
CK

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
