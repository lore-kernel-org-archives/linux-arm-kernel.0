From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 29 Jul 2017 23:09:41 +0200
Subject: [PATCH v1 1/2] arm64: dts: rockchip: add rk3328 i2s nodes
In-Reply-To: <1501143365-76104-2-git-send-email-sugar.zhang@rock-chips.com>
References: <1501143365-76104-1-git-send-email-sugar.zhang@rock-chips.com>
 <1501143365-76104-2-git-send-email-sugar.zhang@rock-chips.com>
Message-ID: <12755546.8f2g0BVaYa@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 27. Juli 2017, 16:16:03 CEST schrieb Sugar Zhang:
> This patch add the i2s dt nodes for rk3328.
> 
> Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
> ---
> 
>  arch/arm64/boot/dts/rockchip/rk3328.dtsi | 33 ++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> index 0be96ce..f1a284b 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> @@ -156,6 +156,39 @@
>  		clock-output-names = "xin24m";
>  	};
>  
> +	i2s0: i2s at ff000000 {
> +		compatible = "rockchip,rk3328-i2s", "rockchip,rk3066-i2s";

It looks like the rockchip,rk3328-i2s compatible is missing in the binding
documentation (Documentation/devicetree/bindings/sound/rockchip-i2s.txt)

Send a patch adding it first please.


Heiko
