From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 29 Oct 2012 22:33:45 +0100
Subject: [PATCH] ARM: dts: imx27-3ds: Remove local watchdog inclusion
In-Reply-To: <1348661261-7124-1-git-send-email-festevam@gmail.com>
References: <1348661261-7124-1-git-send-email-festevam@gmail.com>
Message-ID: <20121029213345.GB1641@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 26, 2012 at 09:07:41AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> imx27.dtsi already register the watchdog, so no need to do it in the board dts
> file.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied, thanks

Sascha

> ---
>  arch/arm/boot/dts/imx27-3ds.dts |    4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx27-3ds.dts b/arch/arm/boot/dts/imx27-3ds.dts
> index 0a8978a..b01c0d7 100644
> --- a/arch/arm/boot/dts/imx27-3ds.dts
> +++ b/arch/arm/boot/dts/imx27-3ds.dts
> @@ -23,10 +23,6 @@
>  	soc {
>  		aipi at 10000000 { /* aipi */
>  
> -			wdog at 10002000 {
> -				status = "okay";
> -			};
> -
>  			uart1: serial at 1000a000 {
>  				fsl,uart-has-rtscts;
>  				status = "okay";
> -- 
> 1.7.9.5
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
