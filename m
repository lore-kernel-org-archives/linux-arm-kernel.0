From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 6 Aug 2012 10:39:09 +0800
Subject: [PATCH 3/3] IIO: arm: Add LRADC to i.MX28 dts
In-Reply-To: <1344007721-11595-4-git-send-email-marex@denx.de>
References: <1344007721-11595-1-git-send-email-marex@denx.de>
 <1344007721-11595-4-git-send-email-marex@denx.de>
Message-ID: <20120806023907.GD18471@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 03, 2012 at 05:28:41PM +0200, Marek Vasut wrote:
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Juergen Beisert <jbe@pengutronix.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Wolfgang Denk <wd@denx.de>
> ---
>  arch/arm/boot/dts/imx28.dtsi |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
> index 4a0f12c..91752d2 100644
> --- a/arch/arm/boot/dts/imx28.dtsi
> +++ b/arch/arm/boot/dts/imx28.dtsi
> @@ -677,7 +677,10 @@
>  			};
>  
>  			lradc at 80050000 {
> +				compatible = "fsl,imx28-lradc";
>  				reg = <0x80050000 2000>;
> +				interrupts = <10 14 15 16 17 18 19
> +						20 21 22 23 24 25>;

Is there a binding doc for this?

Regards,
Shawn

>  				status = "disabled";
>  			};
>  
> -- 
> 1.7.10.4
> 
