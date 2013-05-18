From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 18 May 2013 09:07:09 +0800
Subject: [PATCH] ARM: dts: apf28dev: Add touchscreen support for APF28dev
In-Reply-To: <1368767622-12968-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
References: <1368767622-12968-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
Message-ID: <20130518010707.GA18471@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 17, 2013 at 07:13:41AM +0200, Gwenhael Goavec-Merou wrote:
> 
> Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>

Applied, thanks.

> ---
>  arch/arm/boot/dts/imx28-apf28dev.dts | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/imx28-apf28dev.dts b/arch/arm/boot/dts/imx28-apf28dev.dts
> index 3d905d1..b602494 100644
> --- a/arch/arm/boot/dts/imx28-apf28dev.dts
> +++ b/arch/arm/boot/dts/imx28-apf28dev.dts
> @@ -103,6 +103,7 @@
>  
>  		apbx at 80040000 {
>  			lradc at 80050000 {
> +				fsl,lradc-touchscreen-wires = <4>;
>  				status = "okay";
>  			};
>  
> -- 
> 1.8.1.5
> 
