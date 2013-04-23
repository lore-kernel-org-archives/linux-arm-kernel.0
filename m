From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 23 Apr 2013 15:34:26 +0800
Subject: [RFC PATCH v2 05/13] ARM: mach-imx: cpus/cpu nodes dts updates
In-Reply-To: <1366644455-16550-6-git-send-email-lorenzo.pieralisi@arm.com>
References: <1366644455-16550-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1366644455-16550-6-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <20130423073425.GB27475@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 22, 2013 at 04:27:27PM +0100, Lorenzo Pieralisi wrote:
> This patch updates the in-kernel dts files according to the latest cpus
> and cpu bindings updates for ARM.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Acked-by: Shawn Guo <shawn.guo@linaro.org>

> ---
>  arch/arm/boot/dts/imx23.dtsi | 2 +-
>  arch/arm/boot/dts/imx28.dtsi | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
> index 56afcf4..d98330c 100644
> --- a/arch/arm/boot/dts/imx23.dtsi
> +++ b/arch/arm/boot/dts/imx23.dtsi
> @@ -24,7 +24,7 @@
>  
>  	cpus {
>  		cpu at 0 {
> -			compatible = "arm,arm926ejs";
> +			compatible = "arm,arm926";
>  		};
>  	};
>  
> diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
> index 7ba4966..8c5a3ba 100644
> --- a/arch/arm/boot/dts/imx28.dtsi
> +++ b/arch/arm/boot/dts/imx28.dtsi
> @@ -33,7 +33,7 @@
>  
>  	cpus {
>  		cpu at 0 {
> -			compatible = "arm,arm926ejs";
> +			compatible = "arm,arm926";
>  		};
>  	};
>  
> -- 
> 1.7.12
> 
> 
