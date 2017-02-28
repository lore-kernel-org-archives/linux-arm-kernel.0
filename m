From: robh@kernel.org (Rob Herring)
Date: Mon, 27 Feb 2017 19:15:49 -0600
Subject: [PATCH v4 2/4] Documentation: devicetree: Add LED subnode
 binding for MT6323 PMIC
In-Reply-To: <1487962041-6548-3-git-send-email-sean.wang@mediatek.com>
References: <1487962041-6548-1-git-send-email-sean.wang@mediatek.com>
 <1487962041-6548-3-git-send-email-sean.wang@mediatek.com>
Message-ID: <20170228011549.fqpis445uykyhy7d@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 25, 2017 at 02:47:19AM +0800, sean.wang at mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> This patch adds documentation for devicetree bindings
> for LED support as the subnode of MT6323 PMIC
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  Documentation/devicetree/bindings/mfd/mt6397.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/mt6397.txt b/Documentation/devicetree/bindings/mfd/mt6397.txt
> index 949c85f..c568d52 100644
> --- a/Documentation/devicetree/bindings/mfd/mt6397.txt
> +++ b/Documentation/devicetree/bindings/mfd/mt6397.txt
> @@ -34,6 +34,10 @@ Optional subnodes:
>  - clk
>  	Required properties:
>  		- compatible: "mediatek,mt6397-clk"
> +- led

Your example in patch 1 doesn't match. This one is correct.

> +	Required properties:
> +		- compatible: "mediatek,mt6323-led"
> +	see Documentation/devicetree/bindings/leds/leds-mt6323.txt
>  
>  Example:
>  	pwrap: pwrap at 1000f000 {
> -- 
> 1.9.1
> 
