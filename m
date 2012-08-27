From: marex@denx.de (Marek Vasut)
Date: Mon, 27 Aug 2012 18:58:35 +0200
Subject: [PATCH 2/3] ARM: mx28evk: Add LRADC support
In-Reply-To: <1346084609-31407-2-git-send-email-fabio.estevam@freescale.com>
References: <1346084609-31407-1-git-send-email-fabio.estevam@freescale.com>
 <1346084609-31407-2-git-send-email-fabio.estevam@freescale.com>
Message-ID: <201208271858.35749.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Fabio Estevam,

> Add LRADC support.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Acked-by: Marek Vasut <marex@denx.de>

> ---
>  arch/arm/boot/dts/imx28-evk.dts |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx28-evk.dts
> b/arch/arm/boot/dts/imx28-evk.dts index 8a9a2f4..ed92d61 100644
> --- a/arch/arm/boot/dts/imx28-evk.dts
> +++ b/arch/arm/boot/dts/imx28-evk.dts
> @@ -145,6 +145,10 @@
>  				status = "okay";
>  			};
> 
> +			lradc at 80050000 {
> +				status = "okay";
> +			};
> +
>  			i2c0: i2c at 80058000 {
>  				pinctrl-names = "default";
>  				pinctrl-0 = <&i2c0_pins_a>;

Best regards,
Marek Vasut
