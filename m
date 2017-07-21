From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Fri, 21 Jul 2017 13:49:12 +0200
Subject: [PATCH] Documentation: mtk-quadspi: update DT bindings
In-Reply-To: <1500607619-21969-2-git-send-email-guochun.mao@mediatek.com>
References: <1500607619-21969-1-git-send-email-guochun.mao@mediatek.com>
 <1500607619-21969-2-git-send-email-guochun.mao@mediatek.com>
Message-ID: <3c0fcf5e-8b2d-6db3-b436-0cfba37dcbae@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07/21/2017 05:26 AM, Guochun Mao wrote:
> Add "mediatek,mt2712-nor" and "mediatek,mt7622-nor"
> for nor flash node's compatible.
> 
> Signed-off-by: Guochun Mao <guochun.mao@mediatek.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   .../devicetree/bindings/mtd/mtk-quadspi.txt        |    2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/mtk-quadspi.txt b/Documentation/devicetree/bindings/mtd/mtk-quadspi.txt
> index 5ded66a..9845ff4 100644
> --- a/Documentation/devicetree/bindings/mtd/mtk-quadspi.txt
> +++ b/Documentation/devicetree/bindings/mtd/mtk-quadspi.txt
> @@ -3,6 +3,8 @@
>   Required properties:
>   - compatible: 	  The possible values are:
>   		  "mediatek,mt2701-nor"
> +		  "mediatek,mt2712-nor"
> +		  "mediatek,mt7622-nor"
>   		  "mediatek,mt7623-nor"
>   		  "mediatek,mt8173-nor"
>   		  For mt8173, compatible should be "mediatek,mt8173-nor".
> 
