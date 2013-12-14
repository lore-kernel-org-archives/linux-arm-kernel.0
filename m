From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 14 Dec 2013 21:46:57 +0800
Subject: [PATCH V1 03/11] ARM: dts: imx6qdl-sabrelite: remove usdhc4
 wp-gpio
In-Reply-To: <1386899355-17379-4-git-send-email-troy.kisky@boundarydevices.com>
References: <1386899355-17379-1-git-send-email-troy.kisky@boundarydevices.com>
 <1386899355-17379-4-git-send-email-troy.kisky@boundarydevices.com>
Message-ID: <20131214134656.GC16177@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 12, 2013 at 06:49:07PM -0700, Troy Kisky wrote:
> On Sabre Lite usdhc4 is a micro sd slot, which has no
> write protect.
> 
> Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>

Applied #1, #2 and #3, thanks.

Shawn

> ---
>  arch/arm/boot/dts/imx6qdl-sabrelite.dtsi | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
> index 903da14..c4aa504 100644
> --- a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
> @@ -115,7 +115,6 @@
>  		pinctrl_hog: hoggrp {
>  			fsl,pins = <
>  				MX6QDL_PAD_NANDF_D6__GPIO2_IO06 0x80000000
> -				MX6QDL_PAD_NANDF_D7__GPIO2_IO07 0x80000000
>  				MX6QDL_PAD_EIM_D19__GPIO3_IO19  0x80000000
>  				MX6QDL_PAD_EIM_D22__GPIO3_IO22  0x80000000
>  				MX6QDL_PAD_EIM_D23__GPIO3_IO23  0x80000000
> @@ -230,7 +229,6 @@
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_usdhc4>;
>  	cd-gpios = <&gpio2 6 0>;
> -	wp-gpios = <&gpio2 7 0>;
>  	vmmc-supply = <&reg_3p3v>;
>  	status = "okay";
>  };
> -- 
> 1.8.1.2
> 
