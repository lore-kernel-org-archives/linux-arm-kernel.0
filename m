From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 7 Apr 2013 14:16:27 +0800
Subject: [PATCH] ARM: dts: imx23-olinuxino: mark sdcard cd as broken
In-Reply-To: <1365255730-6299-1-git-send-email-aletes.xgr@gmail.com>
References: <1365255730-6299-1-git-send-email-aletes.xgr@gmail.com>
Message-ID: <20130407061625.GA11898@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 06, 2013 at 10:42:10AM -0300, Alexandre Pereira da Silva wrote:
> The imx23-olinuxino sdcard doesn't have card detect.
> 
> Signed-off-by: Alexandre Pereira da Silva <aletes.xgr@gmail.com>

Applied, thanks.

> ---
>  arch/arm/boot/dts/imx23-olinuxino.dts |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/imx23-olinuxino.dts b/arch/arm/boot/dts/imx23-olinuxino.dts
> index a43141a..d4cc9f8 100644
> --- a/arch/arm/boot/dts/imx23-olinuxino.dts
> +++ b/arch/arm/boot/dts/imx23-olinuxino.dts
> @@ -29,6 +29,7 @@
>  				pinctrl-names = "default";
>  				pinctrl-0 = <&mmc0_4bit_pins_a &mmc0_pins_fixup>;
>  				bus-width = <4>;
> +				broken-cd;
>  				status = "okay";
>  			};
>  
> -- 
> 1.7.10
> 
