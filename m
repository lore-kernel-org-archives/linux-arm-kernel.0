From: sean.wang@mediatek.com (Sean Wang)
Date: Wed, 16 Aug 2017 10:20:23 +0800
Subject: [PATCH v3 1/2] dt-bindings: i2c: Add MediaTek MT7622 i2c binding
In-Reply-To: <1502802495-5064-2-git-send-email-jun.gao@mediatek.com>
References: <1502802495-5064-1-git-send-email-jun.gao@mediatek.com>
 <1502802495-5064-2-git-send-email-jun.gao@mediatek.com>
Message-ID: <1502850023.19230.42.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-08-15 at 21:08 +0800, Jun Gao wrote:
> From: Jun Gao <jun.gao@mediatek.com>
> 
> Add MT7622 i2c binding to binding file and change the compatible
> information formats of all SoCs to the same.
> 
> Signed-off-by: Jun Gao <jun.gao@mediatek.com>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-mtk.txt | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-mtk.txt b/Documentation/devicetree/bindings/i2c/i2c-mtk.txt
> index bd5a7be..71fc0b3 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-mtk.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-mtk.txt
> @@ -4,11 +4,12 @@ The Mediatek's I2C controller is used to interface with I2C devices.
>  
>  Required properties:
>    - compatible: value should be either of the following.
> -      "mediatek,mt2701-i2c", "mediatek,mt6577-i2c": for Mediatek mt2701
> -      "mediatek,mt6577-i2c": for i2c compatible with mt6577.
> -      "mediatek,mt6589-i2c": for i2c compatible with mt6589.
> -      "mediatek,mt7623-i2c", "mediatek,mt6577-i2c": for i2c compatible with mt7623.
> -      "mediatek,mt8173-i2c": for i2c compatible with mt8173.
> +      "mediatek,mt2701-i2c", "mediatek,mt6577-i2c": for Mediatek MT2701
> +      "mediatek,mt6577-i2c": for Mediatek MT6577
> +      "mediatek,mt6589-i2c": for Mediatek MT6589
> +      "mediatek,mt7622-i2c": for Mediatek MT7622
> +      "mediatek,mt7623-i2c", "mediatek,mt6577-i2c": for Mediatek MT7623
> +      "mediatek,mt8173-i2c": for Mediatek MT8173
>    - reg: physical base address of the controller and dma base, length of memory
>      mapped region.
>    - interrupts: interrupt number to the cpu.

Hi, Jun

the patch for new soc support and clean-ups should better be in separate
patch following previous Matthias suggestion. 

http://lists.infradead.org/pipermail/linux-mediatek/2017-August/009740.html


And also spelling for Mediatek should be corrected using MediaTek.


	Sean
