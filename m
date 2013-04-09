From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 9 Apr 2013 20:35:44 +0800
Subject: [PATCH 1/3] ARM: mx28: add auart2 2 pins pinmux to imx28.dtsi
In-Reply-To: <1365425853-12457-1-git-send-email-eric@eukrea.com>
References: <1365425853-12457-1-git-send-email-eric@eukrea.com>
Message-ID: <20130409123542.GG5044@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 08, 2013 at 02:57:31PM +0200, Eric B?nard wrote:
> Add auart2 2 pins configuration on its main pads
> 
> Signed-off-by: Eric B?nard <eric@eukrea.com>

All 3 patches applied, thanks.

> ---
>  arch/arm/boot/dts/imx28.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
> index 7ba4966..13799cf 100644
> --- a/arch/arm/boot/dts/imx28.dtsi
> +++ b/arch/arm/boot/dts/imx28.dtsi
> @@ -308,6 +308,17 @@
>  					fsl,pull-up = <0>;
>  				};
>  
> +				auart2_2pins_b: auart2-2pins at 1 {
> +					reg = <1>;
> +					fsl,pinmux-ids = <
> +						0x3080 /* MX28_PAD_AUART2_RX__AUART2_RX */
> +						0x3090 /* MX28_PAD_AUART2_TX__AUART2_TX */
> +					>;
> +					fsl,drive-strength = <0>;
> +					fsl,voltage = <1>;
> +					fsl,pull-up = <0>;
> +				};
> +
>  				auart3_pins_a: auart3 at 0 {
>  					reg = <0>;
>  					fsl,pinmux-ids = <
> -- 
> 1.7.11.7
> 
