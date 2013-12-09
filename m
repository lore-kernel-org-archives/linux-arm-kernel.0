From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 9 Dec 2013 11:26:07 +0800
Subject: [PATCH 1/3] ARM: dts: mxs: Add 18bit pin config for lcdif.
In-Reply-To: <1386250086-4666-1-git-send-email-denis@eukrea.com>
References: <1386250086-4666-1-git-send-email-denis@eukrea.com>
Message-ID: <20131209032605.GD825@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 05, 2013 at 02:28:04PM +0100, Denis Carikli wrote:
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> Cc: devicetree at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Eric B?nard <eric@eukrea.com>
> Signed-off-by: Denis Carikli <denis@eukrea.com>

Applied #1 and #2.

Shawn

> ---
>  arch/arm/boot/dts/imx28.dtsi |   27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
> index 51ff335..93a7e79 100644
> --- a/arch/arm/boot/dts/imx28.dtsi
> +++ b/arch/arm/boot/dts/imx28.dtsi
> @@ -668,6 +668,33 @@
>  					fsl,pull-up = <MXS_PULL_DISABLE>;
>  				};
>  
> +				lcdif_18bit_pins_a: lcdif-18bit at 0 {
> +					reg = <0>;
> +					fsl,pinmux-ids = <
> +						MX28_PAD_LCD_D00__LCD_D0
> +						MX28_PAD_LCD_D01__LCD_D1
> +						MX28_PAD_LCD_D02__LCD_D2
> +						MX28_PAD_LCD_D03__LCD_D3
> +						MX28_PAD_LCD_D04__LCD_D4
> +						MX28_PAD_LCD_D05__LCD_D5
> +						MX28_PAD_LCD_D06__LCD_D6
> +						MX28_PAD_LCD_D07__LCD_D7
> +						MX28_PAD_LCD_D08__LCD_D8
> +						MX28_PAD_LCD_D09__LCD_D9
> +						MX28_PAD_LCD_D10__LCD_D10
> +						MX28_PAD_LCD_D11__LCD_D11
> +						MX28_PAD_LCD_D12__LCD_D12
> +						MX28_PAD_LCD_D13__LCD_D13
> +						MX28_PAD_LCD_D14__LCD_D14
> +						MX28_PAD_LCD_D15__LCD_D15
> +						MX28_PAD_LCD_D16__LCD_D16
> +						MX28_PAD_LCD_D17__LCD_D17
> +					>;
> +					fsl,drive-strength = <MXS_DRIVE_4mA>;
> +					fsl,voltage = <MXS_VOLTAGE_HIGH>;
> +					fsl,pull-up = <MXS_PULL_DISABLE>;
> +				};
> +
>  				lcdif_16bit_pins_a: lcdif-16bit at 0 {
>  					reg = <0>;
>  					fsl,pinmux-ids = <
> -- 
> 1.7.9.5
> 
