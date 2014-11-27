From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 27 Nov 2014 09:10:55 +0100
Subject: [PATCH] ARM: dts: imx: Update VPU compatible strings
In-Reply-To: <1417035695-18405-1-git-send-email-festevam@gmail.com>
References: <1417035695-18405-1-git-send-email-festevam@gmail.com>
Message-ID: <1417075855.3163.1.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

just one tiny issue below:

Am Mittwoch, den 26.11.2014, 19:01 -0200 schrieb Fabio Estevam:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Update the VPU compatible strings to also use "cnm,coda<model>".
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> Shawn,
> 
> The documentation patch for Documentation/devicetree/bindings/media/coda.txt 
> has been re-sent to the linux-media list with such updates.
> 
>  arch/arm/boot/dts/imx27.dtsi | 2 +-
>  arch/arm/boot/dts/imx53.dtsi | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
> index 107d713..4b063b6 100644
> --- a/arch/arm/boot/dts/imx27.dtsi
> +++ b/arch/arm/boot/dts/imx27.dtsi
> @@ -464,7 +464,7 @@
>  			};
>  
>  			coda: coda at 10023000 {
> -				compatible = "fsl,imx27-vpu";
> +				compatible = "fsl,imx27-vpu", "cnm,codadx6";
>  				reg = <0x10023000 0x0200>;
>  				interrupts = <53>;
>  				clocks = <&clks IMX27_CLK_VPU_BAUD_GATE>,
> diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
> index a30bddf..132410c 100644
> --- a/arch/arm/boot/dts/imx53.dtsi
> +++ b/arch/arm/boot/dts/imx53.dtsi
> @@ -756,7 +756,7 @@
>  			};
>  
>  			vpu: vpu at 63ff4000 {
> -				compatible = "fsl,imx53-vpu";
> +				compatible = "fsl,imx53-vpu","cnm,coda7541";

Missing whitespace here. Other than that,
Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
