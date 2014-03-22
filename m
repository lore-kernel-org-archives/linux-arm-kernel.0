From: shawn.guo@freescale.com (Shawn Guo)
Date: Sat, 22 Mar 2014 14:47:48 +0800
Subject: [PATCH 1/5] ARM: dts: tx53: remove redundant regulator-boot-on
In-Reply-To: <1395235721-13847-1-git-send-email-LW@KARO-electronics.de>
References: <1395235721-13847-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <20140322064747.GD5938@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 19, 2014 at 02:28:37PM +0100, Lothar Wa?mann wrote:
> 
> Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>

Please add something in the commit log, e.g. why regulator-boot-on is
redundant in this case.

Shawn

> ---
>  arch/arm/boot/dts/imx53-tx53-x13x.dts |    2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx53-tx53-x13x.dts b/arch/arm/boot/dts/imx53-tx53-x13x.dts
> index 6480471..c8a3473 100644
> --- a/arch/arm/boot/dts/imx53-tx53-x13x.dts
> +++ b/arch/arm/boot/dts/imx53-tx53-x13x.dts
> @@ -72,7 +72,6 @@
>  			regulator-max-microvolt = <3300000>;
>  			gpio = <&gpio3 29 GPIO_ACTIVE_HIGH>;
>  			enable-active-high;
> -			regulator-boot-on;
>  		};
>  
>  		reg_lcd_pwr1: regulator at 6 {
> @@ -83,7 +82,6 @@
>  			regulator-max-microvolt = <3300000>;
>  			gpio = <&gpio2 31 GPIO_ACTIVE_HIGH>;
>  			enable-active-high;
> -			regulator-boot-on;
>  		};
>  	};
>  };
> -- 
> 1.7.10.4
> 
> 
> 
