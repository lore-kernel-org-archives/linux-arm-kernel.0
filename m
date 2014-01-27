From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 27 Jan 2014 09:47:55 +0100
Subject: [PATCH 1/2] ARM: dts: imx6: edmqmx6: fix wrong usbotg pingroup
In-Reply-To: <1390419567-2643-2-git-send-email-silvio.fricke@gmail.com>
References: <1390419567-2643-1-git-send-email-silvio.fricke@gmail.com>
 <1390419567-2643-2-git-send-email-silvio.fricke@gmail.com>
Message-ID: <20140127084755.GV16215@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 22, 2014 at 08:39:26PM +0100, Silvio F wrote:
> Signed-off-by: Silvio F <silvio.fricke@gmail.com>

Verified this on the schematics, so:

Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>

> ---
>  arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts b/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
> index b8a1ff4..6706d1b 100644
> --- a/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
> +++ b/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
> @@ -266,7 +266,7 @@
>  		};
>  
>  		pinctrl_usbotg: usbotggrp {
> -			fsl,pins = <MX6QDL_USBOTG_PINGRP1>;
> +			fsl,pins = <MX6QDL_USBOTG_PINGRP2>;
>  		};
>  
>  		pinctrl_usdhc3: usdhc3grp {
> -- 
> 1.8.5.2
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
