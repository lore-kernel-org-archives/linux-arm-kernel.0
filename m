From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 30 Jan 2016 13:16:13 +0100
Subject: [PATCH v3 2/2] dt-bindings: rockchip-pinctrl: Support the RK3399
 SoCs compatible
In-Reply-To: <1454153517-52969-3-git-send-email-david.wu@rock-chips.com>
References: <1451997055-47655-1-git-send-email-wdc@rock-chips.com>
 <1454153517-52969-1-git-send-email-david.wu@rock-chips.com>
 <1454153517-52969-3-git-send-email-david.wu@rock-chips.com>
Message-ID: <14543443.RsRWh5K5Uv@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

Am Samstag, 30. Januar 2016, 19:31:57 schrieb David Wu:
> Change-Id: Ic1bdb3dc358837e97d7b48dd58be2f8d9d08d766

please no Change-Id, it's missing the Signed-off, and as Linus Walleij said, 
the compatible addition to the documentation can maybe stay in the pinctrl-
patch itself.

I think both Linus and me overlooked that the binding-doc-addition was 
already correctly included in your v2 patch at the top :-)


Heiko

> ---
>  Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git
> a/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.txt
> b/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.txt index
> 391ef4b..3bb9456 100644
> --- a/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.txt
> @@ -22,6 +22,7 @@ Required properties for iomux controller:
>    - compatible: one of "rockchip,rk2928-pinctrl",
> "rockchip,rk3066a-pinctrl" "rockchip,rk3066b-pinctrl",
> "rockchip,rk3188-pinctrl"
>  		       "rockchip,rk3288-pinctrl", "rockchip,rk3368-pinctrl"
> +		       "rockchip,rk3399-pinctrl"
>    - rockchip,grf: phandle referencing a syscon providing the
>  	 "general register files"
