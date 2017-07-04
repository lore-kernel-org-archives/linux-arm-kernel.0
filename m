From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Tue, 4 Jul 2017 23:21:59 +0200
Subject: [PATCH] dt-bindings: nvmem: mediatek: add support for MediaTek
 MT7623 and MT7622 SoC
In-Reply-To: <fc06fbe496ac237b961b73d51bb823e4ac2f8578.1498808678.git.sean.wang@mediatek.com>
References: <fc06fbe496ac237b961b73d51bb823e4ac2f8578.1498808678.git.sean.wang@mediatek.com>
Message-ID: <7922fc9b-ad4a-fad7-023f-587db484b5aa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 06/30/2017 09:49 AM, sean.wang at mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> This updates dt-binding documentation for MediaTek MT7622 and
> MT7623 SoC. For the both SoCs supported all rely on the fallback
> binding of the generic case with "mediatek,efuse".
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> Signed-off-by: Andrew-CT Chen <andrew-ct.chen@mediatek.com>
> ---

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

>   Documentation/devicetree/bindings/nvmem/mtk-efuse.txt | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/mtk-efuse.txt b/Documentation/devicetree/bindings/nvmem/mtk-efuse.txt
> index 74cf529..0668c45 100644
> --- a/Documentation/devicetree/bindings/nvmem/mtk-efuse.txt
> +++ b/Documentation/devicetree/bindings/nvmem/mtk-efuse.txt
> @@ -3,7 +3,10 @@
>   This binding is intended to represent MTK-EFUSE which is found in most Mediatek SOCs.
>   
>   Required properties:
> -- compatible: should be "mediatek,mt8173-efuse" or "mediatek,efuse"
> +- compatible: should be
> +	      "mediatek,mt7622-efuse", "mediatek,efuse": for MT7622
> +	      "mediatek,mt7623-efuse", "mediatek,efuse": for MT7623
> +	      "mediatek,mt8173-efuse" or "mediatek,efuse": for MT8173
>   - reg: Should contain registers location and length
>   
>   = Data cells =
> 
