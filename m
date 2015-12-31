From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Thu, 31 Dec 2015 12:14:54 +0100
Subject: [PATCH v3 2/5] dt-bindings: mediatek: Modify pinctrl bindings for
 mt2701
In-Reply-To: <1451286546-5920-3-git-send-email-biao.huang@mediatek.com>
References: <1451286546-5920-1-git-send-email-biao.huang@mediatek.com>
 <1451286546-5920-3-git-send-email-biao.huang@mediatek.com>
Message-ID: <56850E2E.4060101@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 28/12/15 08:09, Biao Huang wrote:
> Signed-off-by: Biao Huang <biao.huang@mediatek.com>
> ---
>   .../devicetree/bindings/pinctrl/pinctrl-mt65xx.txt |    9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
>

Reviewed-by: Mathias Brugger <matthias.bgg@gmail.com>

> diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt65xx.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt65xx.txt
> index 0480bc3..9ffb0b2 100644
> --- a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt65xx.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt65xx.txt
> @@ -4,10 +4,11 @@ The Mediatek's Pin controller is used to control SoC pins.
>
>   Required properties:
>   - compatible: value should be one of the following.
> -    (a) "mediatek,mt8135-pinctrl", compatible with mt8135 pinctrl.
> -    (b) "mediatek,mt8173-pinctrl", compatible with mt8173 pinctrl.
> -    (c) "mediatek,mt6397-pinctrl", compatible with mt6397 pinctrl.
> -    (d) "mediatek,mt8127-pinctrl", compatible with mt8127 pinctrl.
> +	"mediatek,mt2701-pinctrl", compatible with mt2701 pinctrl.
> +	"mediatek,mt6397-pinctrl", compatible with mt6397 pinctrl.
> +	"mediatek,mt8127-pinctrl", compatible with mt8127 pinctrl.
> +	"mediatek,mt8135-pinctrl", compatible with mt8135 pinctrl.
> +	"mediatek,mt8173-pinctrl", compatible with mt8173 pinctrl.
>   - pins-are-numbered: Specify the subnodes are using numbered pinmux to
>     specify pins.
>   - gpio-controller : Marks the device node as a gpio controller.
>
