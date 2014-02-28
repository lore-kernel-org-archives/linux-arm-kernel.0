From: tony@atomide.com (Tony Lindgren)
Date: Fri, 28 Feb 2014 14:43:07 -0800
Subject: [PATCH 5/5] ARM: dts: AM33XX: Add ecap interrupt properties
In-Reply-To: <1391029199-3670-6-git-send-email-mporter@linaro.org>
References: <1391029199-3670-1-git-send-email-mporter@linaro.org>
 <1391029199-3670-6-git-send-email-mporter@linaro.org>
Message-ID: <20140228224307.GP13624@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Matt Porter <mporter@linaro.org> [140129 13:02]:
> Add missing interrupt properties to the ecap0, ecap1, and ecap2
> nodes.
> 
> Signed-off-by: Matt Porter <mporter@linaro.org>

Thanks taking this patch only into omap-for-v3.15/dt, the rest
should go via the driver mailing lists.

Regards,

Tony

> ---
>  arch/arm/boot/dts/am33xx.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index 6d95d3d..b4139ba 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -582,6 +582,8 @@
>  				compatible = "ti,am33xx-ecap";
>  				#pwm-cells = <3>;
>  				reg = <0x48300100 0x80>;
> +				interrupts = <31>;
> +				interrupt-names = "ecap0";
>  				ti,hwmods = "ecap0";
>  				status = "disabled";
>  			};
> @@ -610,6 +612,8 @@
>  				compatible = "ti,am33xx-ecap";
>  				#pwm-cells = <3>;
>  				reg = <0x48302100 0x80>;
> +				interrupts = <47>;
> +				interrupt-names = "ecap1";
>  				ti,hwmods = "ecap1";
>  				status = "disabled";
>  			};
> @@ -638,6 +642,8 @@
>  				compatible = "ti,am33xx-ecap";
>  				#pwm-cells = <3>;
>  				reg = <0x48304100 0x80>;
> +				interrupts = <61>;
> +				interrupt-names = "ecap2";
>  				ti,hwmods = "ecap2";
>  				status = "disabled";
>  			};
> -- 
> 1.8.4
> 
