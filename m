From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 6 Jul 2013 11:15:59 +0800
Subject: [PATCH] ARM: dts: imx27 phyCARD-S remove wrong I2C RTC
In-Reply-To: <1373031909-16178-1-git-send-email-mpa@pengutronix.de>
References: <1372782469.486055292@f129.mail.ru>
 <1373031909-16178-1-git-send-email-mpa@pengutronix.de>
Message-ID: <20130706031557.GA30164@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 05, 2013 at 03:45:09PM +0200, Markus Pargmann wrote:
> Fixup of commit 7874d595b78e431f0f661d2fe47625649308a52e

The commit ID is not stable.  I just dropped it and applied the patch.

Shawn

> "ARM: dts: Add device tree support for phycard pca100".
> 
> Remove wrong I2C RTC node.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
> 
> Thanks, Alexander, you are right. I2C2 has no RTC.
> 
> Regards,
> 
> Markus
> 
>  arch/arm/boot/dts/imx27-phytec-phycard-s-som.dts | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx27-phytec-phycard-s-som.dts b/arch/arm/boot/dts/imx27-phytec-phycard-s-som.dts
> index ec52b6d..01ee807 100644
> --- a/arch/arm/boot/dts/imx27-phytec-phycard-s-som.dts
> +++ b/arch/arm/boot/dts/imx27-phytec-phycard-s-som.dts
> @@ -55,11 +55,6 @@
>  		reg = <0x4a>;
>  	};
>  
> -	rtc at 51 {
> -		compatible = "nxp,pcf8563";
> -		reg = <0x51>;
> -	};
> -
>  	at24 at 52 {
>  		compatible = "at,24c32";
>  		pagesize = <32>;
> -- 
> 1.8.2.1
> 
