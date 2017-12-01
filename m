From: robh@kernel.org (Rob Herring)
Date: Thu, 30 Nov 2017 20:06:04 -0600
Subject: [PATCH 1/3] mmc: dt-bindings: add mmc support to MT7623 SoC
In-Reply-To: <3e2c72d18bbe6d7c762fd820195f0fa0b5a45bbf.1511949769.git.sean.wang@mediatek.com>
References: <cover.1511949769.git.sean.wang@mediatek.com>
 <3e2c72d18bbe6d7c762fd820195f0fa0b5a45bbf.1511949769.git.sean.wang@mediatek.com>
Message-ID: <20171201020604.etfzccuwomxgcwmg@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 29, 2017 at 06:10:35PM +0800, sean.wang at mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Add the devicetree binding for MT7623 SoC using MT2701 as the fallback.
> 
> Cc: devicetree at vger.kernel.org
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  Documentation/devicetree/bindings/mmc/mtk-sd.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.txt b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> index 72d2a73..1732588 100644
> --- a/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> @@ -12,6 +12,8 @@ Required properties:
>  	"mediatek,mt8173-mmc": for mmc host ip compatible with mt8173
>  	"mediatek,mt2701-mmc": for mmc host ip compatible with mt2701
>  	"mediatek,mt2712-mmc": for mmc host ip compatible with mt2712
> +	"mediatek,mt7623-mmc",
> +	"mediatek,mt2701-mmc": for mmc host ip compatible with mt7623

Those should be on 1 line ideally.

BTW, I find "for mmc host ip compatible with mt7623" to be mostly 
redundant.

Either way,

Acked-by: Rob Herring <robh@kernel.org>


>  - reg: physical base address of the controller and length
>  - interrupts: Should contain MSDC interrupt number
>  - clocks: Should contain phandle for the clock feeding the MMC controller
> -- 
> 2.7.4
> 
