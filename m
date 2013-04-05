From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 5 Apr 2013 17:16:58 +0800
Subject: [PATCH] ARM: dts: imx23-olinuxino: Set the sdcard as non-removable
In-Reply-To: <1365135413-31493-1-git-send-email-aletes.xgr@gmail.com>
References: <1365135413-31493-1-git-send-email-aletes.xgr@gmail.com>
Message-ID: <20130405091656.GD2667@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 05, 2013 at 01:16:53AM -0300, Alexandre Pereira da Silva wrote:
> The imx23-olinuxino sdcard doesn't support card detect.
> 
So it sounds more like a "broken-cd" rather than "non-removable"?

Shawn

> Signed-off-by: Alexandre Pereira da Silva <aletes.xgr@gmail.com>
> ---
>  arch/arm/boot/dts/imx23-olinuxino.dts |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/imx23-olinuxino.dts b/arch/arm/boot/dts/imx23-olinuxino.dts
> index e7484e4..03f55c2 100644
> --- a/arch/arm/boot/dts/imx23-olinuxino.dts
> +++ b/arch/arm/boot/dts/imx23-olinuxino.dts
> @@ -29,6 +29,7 @@
>  				pinctrl-names = "default";
>  				pinctrl-0 = <&mmc0_4bit_pins_a &mmc0_pins_fixup>;
>  				bus-width = <4>;
> +				non-removable;
>  				status = "okay";
>  			};
>  
> -- 
> 1.7.10
> 
