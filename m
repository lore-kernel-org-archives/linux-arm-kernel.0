From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 3 Sep 2012 22:49:44 +0800
Subject: [PATCHv2 1/3] ARM: dts: mxs: Add missing address and size cells
 in SSP* nodes
In-Reply-To: <1346666749-6094-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1346666749-6094-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20120903144941.GH2362@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Which tree your patches are based on?  Neither does it apply on v3.6-rc
nor my mxs/dt-for-3.7 branch.

Nit: The "*" in subject is not really needed.  "... in SSP nodes" looks
just fine.

Regards,
Shawn

On Mon, Sep 03, 2012 at 12:05:47PM +0200, Maxime Ripard wrote:
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  arch/arm/boot/dts/imx28.dtsi |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
> index 26a166c..8497a0e 100644
> --- a/arch/arm/boot/dts/imx28.dtsi
> +++ b/arch/arm/boot/dts/imx28.dtsi
> @@ -86,6 +86,8 @@
>  			};
>  
>  			ssp0: ssp at 80010000 {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
>  				reg = <0x80010000 2000>;
>  				interrupts = <96 82>;
>  				fsl,ssp-dma-channel = <0>;
> @@ -93,6 +95,8 @@
>  			};
>  
>  			ssp1: ssp at 80012000 {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
>  				reg = <0x80012000 2000>;
>  				interrupts = <97 83>;
>  				fsl,ssp-dma-channel = <1>;
> @@ -100,6 +104,8 @@
>  			};
>  
>  			ssp2: ssp at 80014000 {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
>  				reg = <0x80014000 2000>;
>  				interrupts = <98 84>;
>  				fsl,ssp-dma-channel = <2>;
> @@ -107,6 +113,8 @@
>  			};
>  
>  			ssp3: ssp at 80016000 {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
>  				reg = <0x80016000 2000>;
>  				interrupts = <99 85>;
>  				fsl,ssp-dma-channel = <3>;
> -- 
> 1.7.9.5
> 
