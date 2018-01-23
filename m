From: sean.wang@mediatek.com (Sean Wang)
Date: Tue, 23 Jan 2018 15:55:49 +0800
Subject: [PATCH 1/3] dt-bindings: pwrap: mediatek: add MT6351 PMIC
 support for MT6797
In-Reply-To: <20180123033659.11401-1-argus.lin@mediatek.com>
References: <20180123033659.11401-1-argus.lin@mediatek.com>
Message-ID: <1516694149.12197.25.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2018-01-23 at 11:36 +0800, argus.lin at mediatek.com wrote:
> From: Argus Lin <argus.lin@mediatek.com>
> 
> We add MT6351 PMIC support for MT6797 SoCs.
> 
> Change-Id: I362b2305f674813ffb03ce6f54f7fc4c378b8fd2

should remove change-id, also in the other patches

> Signed-off-by: Argus Lin <argus.lin@mediatek.com>
> ---
>  Documentation/devicetree/bindings/soc/mediatek/pwrap.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/mediatek/pwrap.txt b/Documentation/devicetree/bindings/soc/mediatek/pwrap.txt
> index bf80e3f96f8c..dd573ba5d9a7 100644
> --- a/Documentation/devicetree/bindings/soc/mediatek/pwrap.txt
> +++ b/Documentation/devicetree/bindings/soc/mediatek/pwrap.txt
> @@ -22,6 +22,7 @@ Required properties in pwrap device node.
>  	"mediatek,mt7622-pwrap" for MT7622 SoCs
>  	"mediatek,mt8135-pwrap" for MT8135 SoCs
>  	"mediatek,mt8173-pwrap" for MT8173 SoCs
> +	"mediatek,mt6797-pwrap" for MT6797 SoCs

should be better if add it in alphabetical order

>  - interrupts: IRQ for pwrap in SOC
>  - reg-names: Must include the following entries:
>    "pwrap": Main registers base
