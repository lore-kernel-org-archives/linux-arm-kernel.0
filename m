From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 3 Jun 2013 10:16:23 +0800
Subject: [PATCH 1/4] ARM: dts: imx27-phytec-phycore: Add reset GPIO for FEC
In-Reply-To: <1370066053-25030-1-git-send-email-shc_work@mail.ru>
References: <1370066053-25030-1-git-send-email-shc_work@mail.ru>
Message-ID: <20130603021621.GF13970@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 01, 2013 at 09:54:10AM +0400, Alexander Shiyan wrote:
> FEC (KSZ8001L) reset pin is connected to GPIOC30.
> Add this definition to dts.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

Applied the series, thanks.

Shawn

> ---
>  arch/arm/boot/dts/imx27-phytec-phycore.dts | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/imx27-phytec-phycore.dts b/arch/arm/boot/dts/imx27-phytec-phycore.dts
> index eb7d9fa..a4c0256 100644
> --- a/arch/arm/boot/dts/imx27-phytec-phycore.dts
> +++ b/arch/arm/boot/dts/imx27-phytec-phycore.dts
> @@ -58,6 +58,7 @@
>  
>  		aipi at 10020000 { /* aipi2 */
>  			ethernet at 1002b000 {
> +				phy-reset-gpios = <&gpio3 30 0>;
>  				status = "okay";
>  			};
>  		};
> -- 
> 1.8.1.5
> 
