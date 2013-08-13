From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 13 Aug 2013 16:41:48 +0100
Subject: [PATCH 18/22] ARM: dts: Remove '0x's from OMAP5 DTS file
In-Reply-To: <1374490361-25769-18-git-send-email-lee.jones@linaro.org>
References: <1374490361-25769-1-git-send-email-lee.jones@linaro.org>
 <1374490361-25769-18-git-send-email-lee.jones@linaro.org>
Message-ID: <20130813154148.GB15278@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony, Benoit,

Poke

> Cc: Beno?t Cousson <b-cousson@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: linux-omap at vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  arch/arm/boot/dts/omap5.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
> index e643620..be58604 100644
> --- a/arch/arm/boot/dts/omap5.dtsi
> +++ b/arch/arm/boot/dts/omap5.dtsi
> @@ -604,7 +604,7 @@
>  			ti,hwmods = "wd_timer2";
>  		};
>  
> -		emif1: emif at 0x4c000000 {
> +		emif1: emif at 4c000000 {
>  			compatible	= "ti,emif-4d5";
>  			ti,hwmods	= "emif1";
>  			phy-type	= <2>; /* DDR PHY type: Intelli PHY */
> @@ -615,7 +615,7 @@
>  			hw-caps-temp-alert;
>  		};
>  
> -		emif2: emif at 0x4d000000 {
> +		emif2: emif at 4d000000 {
>  			compatible	= "ti,emif-4d5";
>  			ti,hwmods	= "emif2";
>  			phy-type	= <2>; /* DDR PHY type: Intelli PHY */

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
