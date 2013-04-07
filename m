From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 7 Apr 2013 14:19:13 +0800
Subject: [PATCH] ARM: dts: cfa10036: Add touchscreen support to the
 CFA-10049
In-Reply-To: <1365165182-29502-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1365165182-29502-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20130407061911.GB11898@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 05, 2013 at 02:33:02PM +0200, Alexandre Belloni wrote:
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Applied, thanks.

> ---
>  arch/arm/boot/dts/imx28-cfa10049.dts |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx28-cfa10049.dts b/arch/arm/boot/dts/imx28-cfa10049.dts
> index b9dad4e..f16c1e2 100644
> --- a/arch/arm/boot/dts/imx28-cfa10049.dts
> +++ b/arch/arm/boot/dts/imx28-cfa10049.dts
> @@ -192,6 +192,11 @@
>  			usbphy1: usbphy at 8007e000 {
>  				status = "okay";
>  			};
> +
> +			lradc at 80050000 {
> +				status = "okay";
> +				fsl,lradc-touchscreen-wires = <4>;
> +			};
>  		};
>  	};
>  
> -- 
> 1.7.10.4
> 
