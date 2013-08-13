From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 13 Aug 2013 16:43:05 +0100
Subject: [PATCH 15/22] ARM: dts: Remove '0x's from OMAP3 DTS file
In-Reply-To: <1374490361-25769-15-git-send-email-lee.jones@linaro.org>
References: <1374490361-25769-1-git-send-email-lee.jones@linaro.org>
 <1374490361-25769-15-git-send-email-lee.jones@linaro.org>
Message-ID: <20130813154305.GE15278@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony, Benoit,

Poke

On Mon, 22 Jul 2013, Lee Jones wrote:

> Cc: Beno?t Cousson <b-cousson@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: linux-omap at vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  arch/arm/boot/dts/omap3.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
> index 7d95cda..16420ae 100644
> --- a/arch/arm/boot/dts/omap3.dtsi
> +++ b/arch/arm/boot/dts/omap3.dtsi
> @@ -111,7 +111,7 @@
>  			pinctrl-single,function-mask = <0x7f1f>;
>  		};
>  
> -		omap3_pmx_wkup: pinmux at 0x48002a00 {
> +		omap3_pmx_wkup: pinmux at 48002a00 {
>  			compatible = "ti,omap3-padconf", "pinctrl-single";
>  			reg = <0x48002a00 0x5c>;
>  			#address-cells = <1>;

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
