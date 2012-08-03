From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 3 Aug 2012 16:27:41 +0200
Subject: [PATCH] ARM: dts: imx27-3ds.dts: Fix serial console node
In-Reply-To: <1343658196-24243-1-git-send-email-fabio.estevam@freescale.com>
References: <1343658196-24243-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20120803142741.GZ1451@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 30, 2012 at 11:23:16AM -0300, Fabio Estevam wrote:
> Fix serial console node and allow the board to boot again.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/boot/dts/imx27-3ds.dts |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Applied as fix, thanks

Sascha

> 
> diff --git a/arch/arm/boot/dts/imx27-3ds.dts b/arch/arm/boot/dts/imx27-3ds.dts
> index d3f8296..0a8978a 100644
> --- a/arch/arm/boot/dts/imx27-3ds.dts
> +++ b/arch/arm/boot/dts/imx27-3ds.dts
> @@ -27,7 +27,7 @@
>  				status = "okay";
>  			};
>  
> -			uart at 1000a000 {
> +			uart1: serial at 1000a000 {
>  				fsl,uart-has-rtscts;
>  				status = "okay";
>  			};
> -- 
> 1.7.1
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
