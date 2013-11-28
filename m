From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 28 Nov 2013 11:28:51 +0800
Subject: [PATCH] ARM: dts: imx6sabre: Pass reg property in lvds
In-Reply-To: <1385073793-8543-1-git-send-email-festevam@gmail.com>
References: <1385073793-8543-1-git-send-email-festevam@gmail.com>
Message-ID: <20131128032846.GA5868@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 21, 2013 at 08:43:13PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> The 'reg' property is missing in the lvds nodes, so add them for correctness.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/boot/dts/imx6q-sabrelite.dts  | 1 +
>  arch/arm/boot/dts/imx6qdl-sabresd.dtsi | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
> index ec9e4c1..ab81576 100644
> --- a/arch/arm/boot/dts/imx6q-sabrelite.dts
> +++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
> @@ -169,6 +169,7 @@
>  	status = "okay";
>  
>  	lvds-channel at 0 {
> +		reg = <0>;

It's already defined in arch/arm/boot/dts/imx6qdl.dtsi.

Patch dropped.

Shawn

>  		fsl,data-mapping = "spwg";
>  		fsl,data-width = <18>;
>  		status = "okay";
> diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> index 4239ef9..115bf44 100644
> --- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> @@ -236,6 +236,7 @@
>  	status = "okay";
>  
>  	lvds-channel at 1 {
> +		reg = <1>;
>  		fsl,data-mapping = "spwg";
>  		fsl,data-width = <18>;
>  		status = "okay";
> -- 
> 1.8.1.2
> 
