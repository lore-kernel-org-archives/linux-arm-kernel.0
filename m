From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 14 Aug 2017 11:36:05 +0200
Subject: [PATCH 1/2] dt-bindings: i2c: Add MediaTek MT7622 i2c binding
In-Reply-To: <1502264631-12572-2-git-send-email-jun.gao@mediatek.com>
References: <1502264631-12572-1-git-send-email-jun.gao@mediatek.com>
 <1502264631-12572-2-git-send-email-jun.gao@mediatek.com>
Message-ID: <3384d424-827a-0a4b-d1d6-7d361d8c8391@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/09/2017 09:43 AM, Jun Gao wrote:
> From: Jun Gao <jun.gao@mediatek.com>
> 
> Add MT7622 i2c binding to binding file. Compare to MT8173 i2c
> controller, MT7622 limit message size to 255, and not support
> 4GB DMA mode.
> 
> Signed-off-by: Jun Gao <jun.gao@mediatek.com>
> ---
>   Documentation/devicetree/bindings/i2c/i2c-mtk.txt | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-mtk.txt b/Documentation/devicetree/bindings/i2c/i2c-mtk.txt
> index bd5a7be..ff9ac61 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-mtk.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-mtk.txt
> @@ -4,11 +4,12 @@ The Mediatek's I2C controller is used to interface with I2C devices.
>   
>   Required properties:
>     - compatible: value should be either of the following.
> -      "mediatek,mt2701-i2c", "mediatek,mt6577-i2c": for Mediatek mt2701
> -      "mediatek,mt6577-i2c": for i2c compatible with mt6577.
> -      "mediatek,mt6589-i2c": for i2c compatible with mt6589.
> -      "mediatek,mt7623-i2c", "mediatek,mt6577-i2c": for i2c compatible with mt7623.
> -      "mediatek,mt8173-i2c": for i2c compatible with mt8173.
> +	"mediatek,mt2701-i2c", "mediatek,mt6577-i2c": for Mediatek MT2701
> +	"mediatek,mt6577-i2c": for Mediatek MT6577
> +	"mediatek,mt6589-i2c": for Mediatek MT6589
> +	"mediatek,mt7622-i2c": for Mediatek MT7622
> +	"mediatek,mt7623-i2c", "mediatek,mt6577-i2c": for Mediatek MT7623
> +	"mediatek,mt8173-i2c": for Mediatek MT8173
>     - reg: physical base address of the controller and dma base, length of memory
>       mapped region.
>     - interrupts: interrupt number to the cpu.
> 

In the next series, could you please make sure not to change the indentation.

Thanks a lot,
Matthias
