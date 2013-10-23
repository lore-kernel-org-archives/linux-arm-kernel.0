From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 23 Oct 2013 19:31:36 +0800
Subject: [PATCH v2] ARM: dts: mxs: add auart2 pinmux to imx28.dtsi
In-Reply-To: <1382511537-5072-1-git-send-email-aida.mynzhasova@skitlab.ru>
References: <1382511537-5072-1-git-send-email-aida.mynzhasova@skitlab.ru>
Message-ID: <20131023113128.GA9489@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 23, 2013 at 10:58:57AM +0400, Aida Mynzhasova wrote:
> Add auart2 pins configuration on its main pads
> 
> Signed-off-by: Aida Mynzhasova <aida.mynzhasova@skitlab.ru>

Applied, thanks.

Shawn

> ---
>  arch/arm/boot/dts/imx28.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
> index 918d419..cab4c22 100644
> --- a/arch/arm/boot/dts/imx28.dtsi
> +++ b/arch/arm/boot/dts/imx28.dtsi
> @@ -343,6 +343,19 @@
>  					fsl,pull-up = <MXS_PULL_DISABLE>;
>  				};
>  
> +				auart2_pins_a: auart2-pins at 0 {
> +					reg = <0>;
> +					fsl,pinmux-ids = <
> +						MX28_PAD_AUART2_RX__AUART2_RX
> +						MX28_PAD_AUART2_TX__AUART2_TX
> +						MX28_PAD_AUART2_CTS__AUART2_CTS
> +						MX28_PAD_AUART2_RTS__AUART2_RTS
> +					>;
> +					fsl,drive-strength = <MXS_DRIVE_4mA>;
> +					fsl,voltage = <MXS_VOLTAGE_HIGH>;
> +					fsl,pull-up = <MXS_PULL_DISABLE>;
> +				};
> +
>  				auart3_pins_a: auart3 at 0 {
>  					reg = <0>;
>  					fsl,pinmux-ids = <
> -- 
> 1.8.1.2
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
