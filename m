From: sean.wang@mediatek.com (Sean Wang)
Date: Thu, 3 May 2018 10:01:02 +0800
Subject: [PATCH V4 1/8] dt-bindings: pwrap: mediatek: add MT6351 PMIC
 support for MT6797
In-Reply-To: <20180502092112.3991-2-argus.lin@mediatek.com>
References: <20180502092112.3991-1-argus.lin@mediatek.com>
 <20180502092112.3991-2-argus.lin@mediatek.com>
Message-ID: <1525312862.14792.37.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2018-05-02 at 17:21 +0800, argus.lin at mediatek.com wrote:
> From: Argus Lin <argus.lin@mediatek.com>
> 
> We add MT6351 PMIC support for MT6797 SoCs.
> 
> Signed-off-by: Argus Lin <argus.lin@mediatek.com>
> ---
>  Documentation/devicetree/bindings/soc/mediatek/pwrap.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/mediatek/pwrap.txt b/Documentation/devicetree/bindings/soc/mediatek/pwrap.txt
> index bf80e3f96f8c..f9987c30f0d5 100644
> --- a/Documentation/devicetree/bindings/soc/mediatek/pwrap.txt
> +++ b/Documentation/devicetree/bindings/soc/mediatek/pwrap.txt
> @@ -19,6 +19,7 @@ IP Pairing
>  Required properties in pwrap device node.
>  - compatible:
>  	"mediatek,mt2701-pwrap" for MT2701/7623 SoCs
> +	"mediatek,mt6797-pwrap" for MT6797 SoCs
>  	"mediatek,mt7622-pwrap" for MT7622 SoCs
>  	"mediatek,mt8135-pwrap" for MT8135 SoCs
>  	"mediatek,mt8173-pwrap" for MT8173 SoCs

The content doesn't describe anything about MT6351, which seems to be
inconsistent with its title
