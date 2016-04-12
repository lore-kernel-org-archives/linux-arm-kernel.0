From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 12 Apr 2016 15:50:21 +0800
Subject: [PATCH] ARM: dts: imx28: add alternative pinmuxing for mac0
In-Reply-To: <1459927979-11665-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1459927979-11665-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20160412075021.GC23438@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 06, 2016 at 09:32:59AM +0200, Uwe Kleine-K?nig wrote:
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Applied, thanks.

> ---
>  arch/arm/boot/dts/imx28.dtsi | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
> index 4e073e854742..8058adf42ea6 100644
> --- a/arch/arm/boot/dts/imx28.dtsi
> +++ b/arch/arm/boot/dts/imx28.dtsi
> @@ -423,6 +423,32 @@
>  					fsl,pull-up = <MXS_PULL_ENABLE>;
>  				};
>  
> +				mac0_pins_b: mac0 at 1 {
> +					reg = <1>;
> +					fsl,pinmux-ids = <
> +						MX28_PAD_ENET0_MDC__ENET0_MDC
> +						MX28_PAD_ENET0_MDIO__ENET0_MDIO
> +						MX28_PAD_ENET0_RX_EN__ENET0_RX_EN
> +						MX28_PAD_ENET0_RXD0__ENET0_RXD0
> +						MX28_PAD_ENET0_RXD1__ENET0_RXD1
> +						MX28_PAD_ENET0_RXD2__ENET0_RXD2
> +						MX28_PAD_ENET0_RXD3__ENET0_RXD3
> +						MX28_PAD_ENET0_TX_EN__ENET0_TX_EN
> +						MX28_PAD_ENET0_TXD0__ENET0_TXD0
> +						MX28_PAD_ENET0_TXD1__ENET0_TXD1
> +						MX28_PAD_ENET0_TXD2__ENET0_TXD2
> +						MX28_PAD_ENET0_TXD3__ENET0_TXD3
> +						MX28_PAD_ENET_CLK__CLKCTRL_ENET
> +						MX28_PAD_ENET0_COL__ENET0_COL
> +						MX28_PAD_ENET0_CRS__ENET0_CRS
> +						MX28_PAD_ENET0_TX_CLK__ENET0_TX_CLK
> +						MX28_PAD_ENET0_RX_CLK__ENET0_RX_CLK
> +						>;
> +					fsl,drive-strength = <MXS_DRIVE_8mA>;
> +					fsl,voltage = <MXS_VOLTAGE_HIGH>;
> +					fsl,pull-up = <MXS_PULL_ENABLE>;
> +				};
> +
>  				mac1_pins_a: mac1 at 0 {
>  					reg = <0>;
>  					fsl,pinmux-ids = <
> -- 
> 2.7.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
