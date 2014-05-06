From: tony@atomide.com (Tony Lindgren)
Date: Mon, 5 May 2014 17:37:34 -0700
Subject: [PATCH] ARM: dts: am335x-boneblack: remove use of
 ti,vcc-aux-disable-is-sleep
In-Reply-To: <1398432986-30585-1-git-send-email-jhovold@gmail.com>
References: <1398432986-30585-1-git-send-email-jhovold@gmail.com>
Message-ID: <20140506003734.GO25949@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Johan Hovold <jhovold@gmail.com> [140425 06:37]:
> Remove use of property ti,vcc-aux-disable-is-sleep, which does not
> exist.
> 
> Signed-off-by: Johan Hovold <jhovold@gmail.com>

Thanks applying into omap-for-v3.16/fixes-not-urgent.

Tony

> ---
>  arch/arm/boot/dts/am335x-boneblack.dts | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/am335x-boneblack.dts b/arch/arm/boot/dts/am335x-boneblack.dts
> index 6b71ad95a5cf..305975d3f531 100644
> --- a/arch/arm/boot/dts/am335x-boneblack.dts
> +++ b/arch/arm/boot/dts/am335x-boneblack.dts
> @@ -26,7 +26,6 @@
>  	pinctrl-0 = <&emmc_pins>;
>  	bus-width = <8>;
>  	status = "okay";
> -	ti,vcc-aux-disable-is-sleep;
>  };
>  
>  &am33xx_pinmux {
> -- 
> 1.8.3.2
> 
