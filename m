From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 28 Nov 2013 13:40:41 +0800
Subject: [PATCH 1/2] ARM: dts: imx51-babbage: Fix chipselect level for
 dataflash on spi0.1
In-Reply-To: <1385553346-20642-1-git-send-email-shc_work@mail.ru>
References: <1385553346-20642-1-git-send-email-shc_work@mail.ru>
Message-ID: <20131128054039.GB5914@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 27, 2013 at 03:55:45PM +0400, Alexander Shiyan wrote:
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

Applied both, thanks.

Shawn

> ---
>  arch/arm/boot/dts/imx51-babbage.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
> index bbe899f..ee0deb3 100644
> --- a/arch/arm/boot/dts/imx51-babbage.dts
> +++ b/arch/arm/boot/dts/imx51-babbage.dts
> @@ -138,7 +138,7 @@
>  	pinctrl-0 = <&pinctrl_ecspi1>;
>  	fsl,spi-num-chipselects = <2>;
>  	cs-gpios = <&gpio4 24 GPIO_ACTIVE_HIGH>,
> -		   <&gpio4 25 GPIO_ACTIVE_HIGH>;
> +		   <&gpio4 25 GPIO_ACTIVE_LOW>;
>  	status = "okay";
>  
>  	pmic: mc13892 at 0 {
> -- 
> 1.8.3.2
> 
