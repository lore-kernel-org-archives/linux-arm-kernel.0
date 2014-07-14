From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 14 Jul 2014 15:35:07 +0800
Subject: [PATCH] ARM: dts: vf610: fix length of eshdc1 register property
In-Reply-To: <1405322326-2183-1-git-send-email-stefan@agner.ch>
References: <1405322326-2183-1-git-send-email-stefan@agner.ch>
Message-ID: <20140714073506.GE2197@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 14, 2014 at 09:18:46AM +0200, Stefan Agner wrote:
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---

Applied, thanks.

>  arch/arm/boot/dts/vf610.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/vf610.dtsi b/arch/arm/boot/dts/vf610.dtsi
> index 6cc314e..6a6190c 100644
> --- a/arch/arm/boot/dts/vf610.dtsi
> +++ b/arch/arm/boot/dts/vf610.dtsi
> @@ -362,7 +362,7 @@
>  
>  			esdhc1: esdhc at 400b2000 {
>  				compatible = "fsl,imx53-esdhc";
> -				reg = <0x400b2000 0x4000>;
> +				reg = <0x400b2000 0x1000>;
>  				interrupts = <0 28 0x04>;
>  				clocks = <&clks VF610_CLK_IPG_BUS>,
>  					<&clks VF610_CLK_PLATFORM_BUS>,
> -- 
> 2.0.1
> 
