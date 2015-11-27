From: robh@kernel.org (Rob Herring)
Date: Fri, 27 Nov 2015 14:38:00 -0600
Subject: [PATCH 2/5] dt-bindings: mediatek: Modify pinctrl bindings for
 mt2701
In-Reply-To: <1448527472-20651-3-git-send-email-biao.huang@mediatek.com>
References: <1448527472-20651-1-git-send-email-biao.huang@mediatek.com>
 <1448527472-20651-3-git-send-email-biao.huang@mediatek.com>
Message-ID: <20151127203800.GA9092@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 26, 2015 at 04:44:29PM +0800, Biao Huang wrote:
> Signed-off-by: Biao Huang <biao.huang@mediatek.com>
> ---
>  .../devicetree/bindings/pinctrl/pinctrl-mt65xx.txt |    9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt65xx.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt65xx.txt
> index 0480bc3..ca6a27a 100644
> --- a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt65xx.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt65xx.txt
> @@ -4,10 +4,11 @@ The Mediatek's Pin controller is used to control SoC pins.
>  
>  Required properties:
>  - compatible: value should be one of the following.
> -    (a) "mediatek,mt8135-pinctrl", compatible with mt8135 pinctrl.
> -    (b) "mediatek,mt8173-pinctrl", compatible with mt8173 pinctrl.
> -    (c) "mediatek,mt6397-pinctrl", compatible with mt6397 pinctrl.
> -    (d) "mediatek,mt8127-pinctrl", compatible with mt8127 pinctrl.
> +    (a) "mediatek,mt2701-pinctrl", compatible with mt2701 pinctrl.
> +    (b) "mediatek,mt6397-pinctrl", compatible with mt6397 pinctrl.
> +    (c) "mediatek,mt8135-pinctrl", compatible with mt8135 pinctrl.
> +    (d) "mediatek,mt8173-pinctrl", compatible with mt8173 pinctrl.
> +    (e) "mediatek,mt8127-pinctrl", compatible with mt8127 pinctrl.

If you were trying to sort these, they still aren't quite sorted. There 
is no point in sorting if you number (or letter) them because you will 
have to update many lines on any change. So drop the (a), (b), (c), etc.

Rob

>  - pins-are-numbered: Specify the subnodes are using numbered pinmux to
>    specify pins.
>  - gpio-controller : Marks the device node as a gpio controller.
> -- 
> 1.7.9.5
> 
