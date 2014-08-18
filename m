From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 18 Aug 2014 14:43:19 +0800
Subject: [PATCH] ARM: dts: imx6: edmqmx6: change enet reset pin
In-Reply-To: <76f23118ec2c07696aefd4fd88133f42837d45a5.1407765032.git.silvio.fricke@gmail.com>
References: <cover.1407765032.git.silvio.fricke@gmail.com>
 <76f23118ec2c07696aefd4fd88133f42837d45a5.1407765032.git.silvio.fricke@gmail.com>
Message-ID: <20140818064316.GF2114@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 11, 2014 at 03:53:11PM +0200, Silvio Fricke wrote:
> Signed-off-by: Silvio Fricke <silvio.fricke@gmail.com>
> ---
>  arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied, thanks.

> 
> diff --git a/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts b/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
> index 8c1cb53..4fa2543 100644
> --- a/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
> +++ b/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
> @@ -119,7 +119,7 @@
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_enet>;
>  	phy-mode = "rgmii";
> -	phy-reset-gpios = <&gpio3 23 0>;
> +	phy-reset-gpios = <&gpio1 25 0>;
>  	phy-supply = <&vgen2_1v2_eth>;
>  	status = "okay";
>  };
> @@ -339,6 +339,7 @@
>  				MX6QDL_PAD_ENET_REF_CLK__ENET_TX_CLK	0x1b0b0
>  				MX6QDL_PAD_ENET_MDIO__ENET_MDIO		0x1b0b0
>  				MX6QDL_PAD_ENET_MDC__ENET_MDC		0x1b0b0
> +				MX6QDL_PAD_ENET_CRS_DV__GPIO1_IO25	0x1b0b0
>  				MX6QDL_PAD_GPIO_16__ENET_REF_CLK	0x4001b0a8
>  			>;
>  		};
> -- 
> 2.0.3
> 
