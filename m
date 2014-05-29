From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 29 May 2014 15:51:17 +0800
Subject: [PATCH] ARM: dts: imx51-babbage: Add PMIC RTC support
In-Reply-To: <1400780705-19305-1-git-send-email-fabio.estevam@freescale.com>
References: <1400780705-19305-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20140529075115.GD8860@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 22, 2014 at 02:45:05PM -0300, Fabio Estevam wrote:
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied, thanks.

Shawn

> ---
>  arch/arm/boot/dts/imx51-babbage.dts | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
> index 6bc3243..ee51a10 100644
> --- a/arch/arm/boot/dts/imx51-babbage.dts
> +++ b/arch/arm/boot/dts/imx51-babbage.dts
> @@ -203,6 +203,7 @@
>  		reg = <0>;
>  		interrupt-parent = <&gpio1>;
>  		interrupts = <8 IRQ_TYPE_LEVEL_HIGH>;
> +		fsl,mc13xxx-uses-rtc;
>  
>  		regulators {
>  			sw1_reg: sw1 {
> -- 
> 1.8.3.2
> 
