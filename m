From: marex@denx.de (Marek Vasut)
Date: Wed, 27 Jun 2012 13:47:57 +0200
Subject: [PATCH 1/2] ARM: dts: imx28: Add additionnal muxing options to
 iMX28 DTSI
In-Reply-To: <1340785092-27035-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1340785092-27035-1-git-send-email-maxime.ripard@free-electrons.com>
 <1340785092-27035-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <201206271347.57707.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Maxime Ripard,

> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> Cc: Brian Lily <brian@crystalfontz.com>

Reviewed-by: Marek Vasut <marex@denx.de>

> ---
>  arch/arm/boot/dts/imx28.dtsi |   17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
> index 4634cb8..2b067d2 100644
> --- a/arch/arm/boot/dts/imx28.dtsi
> +++ b/arch/arm/boot/dts/imx28.dtsi
> @@ -167,6 +167,14 @@
>  					fsl,pull-up = <0>;
>  				};
> 
> +				duart_pins_b: duart at 1 {
> +					reg = <1>;
> +					fsl,pinmux-ids = <0x3022 0x3032>;
> +					fsl,drive-strength = <0>;
> +					fsl,voltage = <1>;
> +					fsl,pull-up = <0>;
> +				};
> +
>  				mac0_pins_a: mac0 at 0 {
>  					reg = <0>;
>  					fsl,pinmux-ids = <0x4000 0x4010 0x4020
> @@ -196,6 +204,15 @@
>  					fsl,pull-up = <1>;
>  				};
> 
> +				mmc0_4bit_pins_a: mmc0-4bit at 0 {
> +					reg = <0>;
> +					fsl,pinmux-ids = <0x2000 0x2010 0x2020
> +						0x2030 0x2080 0x2090 0x20a0>;
> +					fsl,drive-strength = <1>;
> +					fsl,voltage = <1>;
> +					fsl,pull-up = <1>;
> +				};
> +
>  				mmc0_cd_cfg: mmc0-cd-cfg {
>  					fsl,pinmux-ids = <0x2090>;
>  					fsl,pull-up = <0>;

Best regards,
Marek Vasut
