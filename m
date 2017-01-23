From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 23 Jan 2017 12:15:42 +0000
Subject: [PATCH 2/4] Documentation: devicetree: Add LED subnode binding
 for MT6323 PMIC
In-Reply-To: <1485143685-11808-3-git-send-email-sean.wang@mediatek.com>
References: <1485143685-11808-1-git-send-email-sean.wang@mediatek.com>
 <1485143685-11808-3-git-send-email-sean.wang@mediatek.com>
Message-ID: <20170123121542.GN16020@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 23 Jan 2017, sean.wang at mediatek.com wrote:

> From: Sean Wang <sean.wang@mediatek.com>
> 
> This patch adds documentation for devicetree bindings
> for LED support as the subnode of MT6323 PMIC
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  Documentation/devicetree/bindings/mfd/mt6397.txt | 4 ++++
>  1 file changed, 4 insertions(+)

Applied, thanks.

> diff --git a/Documentation/devicetree/bindings/mfd/mt6397.txt b/Documentation/devicetree/bindings/mfd/mt6397.txt
> index 949c85f..c568d52 100644
> --- a/Documentation/devicetree/bindings/mfd/mt6397.txt
> +++ b/Documentation/devicetree/bindings/mfd/mt6397.txt
> @@ -34,6 +34,10 @@ Optional subnodes:
>  - clk
>  	Required properties:
>  		- compatible: "mediatek,mt6397-clk"
> +- led
> +	Required properties:
> +		- compatible: "mediatek,mt6323-led"
> +	see Documentation/devicetree/bindings/leds/leds-mt6323.txt
>  
>  Example:
>  	pwrap: pwrap at 1000f000 {

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
