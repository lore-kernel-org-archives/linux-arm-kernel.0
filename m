From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 26 Nov 2013 10:57:46 +0800
Subject: [PATCH] [ARM] imx27-apf27dev: fix display size
In-Reply-To: <1385365544-70498-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
References: <1385365544-70498-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
Message-ID: <20131126025744.GF30476@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 25, 2013 at 08:45:44AM +0100, Gwenhael Goavec-Merou wrote:
> Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>

Applied, thanks.

> ---
>  arch/arm/boot/dts/imx27-apf27dev.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx27-apf27dev.dts b/arch/arm/boot/dts/imx27-apf27dev.dts
> index 7d90877..9197329 100644
> --- a/arch/arm/boot/dts/imx27-apf27dev.dts
> +++ b/arch/arm/boot/dts/imx27-apf27dev.dts
> @@ -22,10 +22,10 @@
>  		bits-per-pixel = <16>;  /* non-standard but required */
>  		fsl,pcr = <0xfae80083>;	/* non-standard but required */
>  		display-timings {
> -			timing0: 640x480 {
> +			timing0: 800x480 {
>  				clock-frequency = <33000033>;
>  				hactive = <800>;
> -				vactive = <640>;
> +				vactive = <480>;
>  				hback-porch = <96>;
>  				hfront-porch = <96>;
>  				vback-porch = <20>;
> -- 
> 1.8.3.2
> 
