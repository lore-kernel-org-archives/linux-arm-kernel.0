From: chauveau.julien@gmail.com (Julien Chauveau)
Date: Sat, 16 Sep 2017 23:04:48 +0200
Subject: [PATCH 5/9] dt-bindings: add compatibles for rk3066/rk3188 power
 controllers
In-Reply-To: <20170915083357.11296-6-heiko@sntech.de>
References: <20170915083357.11296-1-heiko@sntech.de>
 <20170915083357.11296-6-heiko@sntech.de>
Message-ID: <c2f4f70e-e5e7-9432-035d-fdf885eb53d0@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Heiko,

There are a few copy/paste errors in the documentation.


Le 15/09/2017 ? 10:33, Heiko Stuebner a ?crit?:
> Add the compatible values for the power-domain controllers found on
> rk3066 and rk3188.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>   Documentation/devicetree/bindings/soc/rockchip/power_domain.txt | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/soc/rockchip/power_domain.txt b/Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
> index 301d2a9bc1b8..1c42c5b7ca6a 100644
> --- a/Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
> +++ b/Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
> @@ -5,6 +5,8 @@ powered up/down by software based on different application scenes to save power.
>   
>   Required properties for power domain controller:
>   - compatible: Should be one of the following.
> +	"rockchip,rk3066-power-controller" - for RK3288 SoCs.
> +	"rockchip,rk3188-power-controller" - for RK3288 SoCs.
These should be for RK3066 and RK3188.
>   	"rockchip,rk3288-power-controller" - for RK3288 SoCs.
>   	"rockchip,rk3328-power-controller" - for RK3328 SoCs.
>   	"rockchip,rk3366-power-controller" - for RK3366 SoCs.
> @@ -17,6 +19,8 @@ Required properties for power domain controller:
>   
>   Required properties for power domain sub nodes:
>   - reg: index of the power domain, should use macros in:
> +	"include/dt-bindings/power/rk3066-power.h" - for RK3288 type power domain.
> +	"include/dt-bindings/power/rk3188-power.h" - for RK3288 type power domain.
Same here.
>   	"include/dt-bindings/power/rk3288-power.h" - for RK3288 type power domain.
>   	"include/dt-bindings/power/rk3328-power.h" - for RK3328 type power domain.
>   	"include/dt-bindings/power/rk3366-power.h" - for RK3366 type power domain.
Julien
