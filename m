From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 22 Apr 2013 13:05:49 +0800
Subject: [PATCH 7/8] ARM: mx5: Add PWM1 pinctrl data
In-Reply-To: <1366579808-12067-7-git-send-email-marex@denx.de>
References: <1366579808-12067-1-git-send-email-marex@denx.de>
 <1366579808-12067-7-git-send-email-marex@denx.de>
Message-ID: <20130422050547.GE10821@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 21, 2013 at 11:30:07PM +0200, Marek Vasut wrote:
> This patch adds pinctrl data for PWM1 on MX53.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
>  arch/arm/boot/dts/imx53.dtsi |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
> index 91fc8cc..c343ba6 100644
> --- a/arch/arm/boot/dts/imx53.dtsi
> +++ b/arch/arm/boot/dts/imx53.dtsi
> @@ -653,6 +653,14 @@
>  						>;
>  					};
>  				};
> +
> +				pwm1 {

I put the node after owire.

Shawn

> +					pinctrl_pwm1_1: pwm1grp-1 {
> +						fsl,pins = <
> +							MX53_PAD_DISP0_DAT8__PWM1_PWMO	0x5
> +						>;
> +					};
> +				};
>  			};
>  
>  			gpr: iomuxc-gpr at 53fa8000 {
> -- 
> 1.7.10.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
