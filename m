From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 29 Aug 2012 09:14:58 +0200
Subject: [PATCH] ARM: imx27-phytec-phycore: Fix I2C EEPROM address
In-Reply-To: <1346196165-5024-1-git-send-email-festevam@gmail.com>
References: <1346196165-5024-1-git-send-email-festevam@gmail.com>
Message-ID: <20120829071458.GU26594@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 28, 2012 at 08:22:45PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Fix I2C EEPROM address as per 24c32 datasheet.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied, thanks

Sascha

> ---
>  arch/arm/boot/dts/imx27-phytec-phycore.dts |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx27-phytec-phycore.dts b/arch/arm/boot/dts/imx27-phytec-phycore.dts
> index 2b0ff60..2acc86c 100644
> --- a/arch/arm/boot/dts/imx27-phytec-phycore.dts
> +++ b/arch/arm/boot/dts/imx27-phytec-phycore.dts
> @@ -49,7 +49,7 @@
>  			i2c at 1001d000 {
>  				clock-frequency = <400000>;
>  				status = "okay";
> -				at24 at 4c {
> +				at24 at 52 {
>  					compatible = "at,24c32";
>  					pagesize = <32>;
>  					reg = <0x52>;
> -- 
> 1.7.9.5
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
