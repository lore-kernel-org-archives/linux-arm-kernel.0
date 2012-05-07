From: marex@denx.de (Marek Vasut)
Date: Tue, 8 May 2012 01:40:54 +0200
Subject: [PATCH 6/6] ARM: mxs: add mxs-dma dt support
In-Reply-To: <1336400595-12964-7-git-send-email-shawn.guo@linaro.org>
References: <1336400595-12964-1-git-send-email-shawn.guo@linaro.org>
 <1336400595-12964-7-git-send-email-shawn.guo@linaro.org>
Message-ID: <201205080140.54370.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Shawn Guo,

> From: Dong Aisheng <dong.aisheng@linaro.org>
> 
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Huang Shijie <b32955@freescale.com>
> Reviewed-by: Marek Vasut <marek.vasut@gmail.com>

Acked-by: Marek Vasut <marex@denx.de>

> Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  arch/arm/boot/dts/imx23.dtsi |    4 ++--
>  arch/arm/boot/dts/imx28.dtsi |    4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
> index fb09ccd..a85ef55 100644
> --- a/arch/arm/boot/dts/imx23.dtsi
> +++ b/arch/arm/boot/dts/imx23.dtsi
> @@ -42,8 +42,8 @@
>  			};
> 
>  			dma-apbh at 80004000 {
> +				compatible = "fsl,imx23-dma-apbh";
>  				reg = <0x80004000 2000>;
> -				status = "disabled";
>  			};
> 
>  			ecc at 80008000 {
> @@ -97,8 +97,8 @@
>  			};
> 
>  			dma-apbx at 80024000 {
> +				compatible = "fsl,imx23-dma-apbx";
>  				reg = <0x80024000 2000>;
> -				status = "disabled";
>  			};
> 
>  			dcp at 80028000 {
> diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
> index 5daf757..a17fbfc 100644
> --- a/arch/arm/boot/dts/imx28.dtsi
> +++ b/arch/arm/boot/dts/imx28.dtsi
> @@ -48,8 +48,8 @@
>  			};
> 
>  			dma-apbh at 80004000 {
> +				compatible = "fsl,imx28-dma-apbh";
>  				reg = <0x80004000 2000>;
> -				status = "disabled";
>  			};
> 
>  			perfmon at 80006000 {
> @@ -140,8 +140,8 @@
>  			};
> 
>  			dma-apbx at 80024000 {
> +				compatible = "fsl,imx28-dma-apbx";
>  				reg = <0x80024000 2000>;
> -				status = "disabled";
>  			};
> 
>  			dcp at 80028000 {

Best regards,
Marek Vasut
