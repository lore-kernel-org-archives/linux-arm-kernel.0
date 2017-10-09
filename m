From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 9 Oct 2017 16:54:45 +0200
Subject: [PATCH v2 03/13] mmc: dt-bindings: make compatible explicit
In-Reply-To: <1507548926-9555-4-git-send-email-chaotian.jing@mediatek.com>
References: <1507548926-9555-1-git-send-email-chaotian.jing@mediatek.com>
 <1507548926-9555-4-git-send-email-chaotian.jing@mediatek.com>
Message-ID: <e4e5fa8b-b6a5-dc70-fbfc-6328493cd073@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/09/2017 01:35 PM, Chaotian Jing wrote:
> the driver has updated to have an explicit compatible, so update
> binding file according to the driver change.
> 
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> ---
>   Documentation/devicetree/bindings/mmc/mtk-sd.txt | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.txt b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> index 3e0a97c..2bb585b 100644
> --- a/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> @@ -8,8 +8,8 @@ and the properties used by the msdc driver.
>   
>   Required properties:
>   - compatible: value should be either of the following.
> -	"mediatek,mt8173-mmc","mediatek,mt8135-mmc": for mmc host ip compatible with mt8135
> -	"mediatek,mt8173-mmc","mediatek,mt8135-mmc": for mmc host ip compatible with mt8173
> +	"mediatek,mt8135-mmc": for mmc host ip compatible with mt8135
> +	"mediatek,mt8173-mmc": for mmc host ip compatible with mt8173

You can merge this with patch 1.

>   	"mediatek,mt2701-mmc": for mmc host ip compatible with mt2701
>   	"mediatek,mt2712-mmc": for mmc host ip compatible with mt2712
>   - reg: physical base address of the controller and length
> 
