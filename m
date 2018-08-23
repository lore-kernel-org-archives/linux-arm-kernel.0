From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 23 Aug 2018 08:57:17 +0200
Subject: [PATCH] ARM: dts: imx6ull: correct machine model name
In-Reply-To: <1535005849-14046-1-git-send-email-Anson.Huang@nxp.com>
References: <1535005849-14046-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <20180823065717.ibntomnnamkdbyyq@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Anson,

The board name should be in the subject to let the reader know this is
no generic i.MX6ull change.

Sascha

On Thu, Aug 23, 2018 at 02:30:49PM +0800, Anson Huang wrote:
> i.MX6ULL is a lite version of i.MX6UL, its full name
> is i.MX6 UltraLiteLite, NOT UlltraLite.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  arch/arm/boot/dts/imx6ull-14x14-evk.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx6ull-14x14-evk.dts b/arch/arm/boot/dts/imx6ull-14x14-evk.dts
> index 30ef603..0ba6454 100644
> --- a/arch/arm/boot/dts/imx6ull-14x14-evk.dts
> +++ b/arch/arm/boot/dts/imx6ull-14x14-evk.dts
> @@ -45,7 +45,7 @@
>  #include "imx6ul-14x14-evk.dtsi"
>  
>  / {
> -	model = "Freescale i.MX6 UlltraLite 14x14 EVK Board";
> +	model = "Freescale i.MX6 UltraLiteLite 14x14 EVK Board";
>  	compatible = "fsl,imx6ull-14x14-evk", "fsl,imx6ull";
>  };
>  
> -- 
> 2.7.4
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
