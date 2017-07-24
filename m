From: robh@kernel.org (Rob Herring)
Date: Mon, 24 Jul 2017 11:14:11 -0500
Subject: [PATCH] Documentation: mtk-quadspi: update DT bindings
In-Reply-To: <1500607619-21969-2-git-send-email-guochun.mao@mediatek.com>
References: <1500607619-21969-1-git-send-email-guochun.mao@mediatek.com>
 <1500607619-21969-2-git-send-email-guochun.mao@mediatek.com>
Message-ID: <20170724161411.6fjl7eee4auvco5z@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 21, 2017 at 11:26:59AM +0800, Guochun Mao wrote:
> Add "mediatek,mt2712-nor" and "mediatek,mt7622-nor"
> for nor flash node's compatible.

The subject could be improved because it is exactly the same as the last 
patch adding the 2701 and 7623. Also, use "dt-bindings: mtd: ..." for 
the subject prefix.

> 
> Signed-off-by: Guochun Mao <guochun.mao@mediatek.com>
> ---
>  .../devicetree/bindings/mtd/mtk-quadspi.txt        |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/mtk-quadspi.txt b/Documentation/devicetree/bindings/mtd/mtk-quadspi.txt
> index 5ded66a..9845ff4 100644
> --- a/Documentation/devicetree/bindings/mtd/mtk-quadspi.txt
> +++ b/Documentation/devicetree/bindings/mtd/mtk-quadspi.txt
> @@ -3,6 +3,8 @@
>  Required properties:
>  - compatible: 	  The possible values are:
>  		  "mediatek,mt2701-nor"
> +		  "mediatek,mt2712-nor"
> +		  "mediatek,mt7622-nor"
>  		  "mediatek,mt7623-nor"
>  		  "mediatek,mt8173-nor"
>  		  For mt8173, compatible should be "mediatek,mt8173-nor".
> -- 
> 1.7.9.5
> 
