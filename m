From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 18 Oct 2018 20:43:04 +0200
Subject: [PATCH v1 1/3] ARM: dts: imx6sll: fix typo for fsl,imx6sll-i2c
 node
In-Reply-To: <20181018112615.29362-2-o.rempel@pengutronix.de>
References: <20181018112615.29362-1-o.rempel@pengutronix.de>
 <20181018112615.29362-2-o.rempel@pengutronix.de>
Message-ID: <20181018184304.ln6xd3iev64vkv7e@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 18, 2018 at 01:26:13PM +0200, Oleksij Rempel wrote:
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  arch/arm/boot/dts/imx6sll.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx6sll.dtsi b/arch/arm/boot/dts/imx6sll.dtsi
> index 000e6136a9d6..3e6ffaf5f104 100644
> --- a/arch/arm/boot/dts/imx6sll.dtsi
> +++ b/arch/arm/boot/dts/imx6sll.dtsi
> @@ -709,7 +709,7 @@
>  			i2c1: i2c at 21a0000 {
>  				#address-cells = <1>;
>  				#size-cells = <0>;
> -				compatible = "fs,imx6sll-i2c", "fsl,imx21-i2c";
> +				compatible = "fsl,imx6sll-i2c", "fsl,imx21-i2c";

Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
