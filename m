From: tony@atomide.com (Tony Lindgren)
Date: Wed, 7 Jan 2015 16:11:18 -0800
Subject: [PATCH] ARM: OMAP: DTS: N950/N9: add twl_power
In-Reply-To: <1419624589-10432-1-git-send-email-aaro.koskinen@iki.fi>
References: <1419624589-10432-1-git-send-email-aaro.koskinen@iki.fi>
Message-ID: <20150108001117.GO13010@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Aaro Koskinen <aaro.koskinen@iki.fi> [141226 12:12]:
> Add twl_power for N950/N9. Start with the simplest configuration to just
> enable power off.
> 
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>

Applying into omap-for-v3.20/dt thanks.

Tony

> ---
>  arch/arm/boot/dts/omap3-n950-n9.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/omap3-n950-n9.dtsi b/arch/arm/boot/dts/omap3-n950-n9.dtsi
> index 1e49dfe..c41db94 100644
> --- a/arch/arm/boot/dts/omap3-n950-n9.dtsi
> +++ b/arch/arm/boot/dts/omap3-n950-n9.dtsi
> @@ -60,6 +60,11 @@
>  
>  &twl {
>  	compatible = "ti,twl5031";
> +
> +	twl_power: power {
> +		compatible = "ti,twl4030-power";
> +		ti,use_poweroff;
> +	};
>  };
>  
>  &twl_gpio {
> -- 
> 2.2.0
> 
