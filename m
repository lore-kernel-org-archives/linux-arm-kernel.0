From: tony@atomide.com (Tony Lindgren)
Date: Thu, 23 Feb 2012 10:57:18 -0800
Subject: [PATCH v2 4/4] arm/dts: OMAP3: Add mmc controller nodes and
 board data
In-Reply-To: <1329998490-27555-5-git-send-email-rnayak@ti.com>
References: <1329998490-27555-1-git-send-email-rnayak@ti.com>
 <1329998490-27555-5-git-send-email-rnayak@ti.com>
Message-ID: <20120223185718.GZ18185@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> --- a/arch/arm/boot/dts/omap3.dtsi
> +++ b/arch/arm/boot/dts/omap3.dtsi
> @@ -113,5 +113,31 @@
>  			#size-cells = <0>;
>  			ti,hwmods = "i2c3";
>  		};
> +
> +		mmc1: mmc at 1 {
> +			compatible = "ti,omap2-hsmmc";
> +			ti,hwmods = "mmc1";
> +			ti,dual-volt;
> +		};
> +
> +		mmc2: mmc at 2 {
> +			compatible = "ti,omap2-hsmmc";
> +			ti,hwmods = "mmc2";
> +		};
> +
> +		mmc3: mmc at 3 {
> +			compatible = "ti,omap2-hsmmc";
> +			ti,hwmods = "mmc3";
> +		};
> +
> +		mmc4: mmc at 4 {
> +			compatible = "ti,omap2-hsmmc";
> +			ti,hwmods = "mmc4";
> +		};
> +
> +		mmc5: mmc at 5 {
> +			compatible = "ti,omap2-hsmmc";
> +			ti,hwmods = "mmc5";
> +		};
>  	};
>  };

These all should all be "ti,omap3-hsmmc" I guess?

Tony
