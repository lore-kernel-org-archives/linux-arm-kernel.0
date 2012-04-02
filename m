From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 2 Apr 2012 11:26:10 +0200
Subject: [PATCH v2 2/3] i.MX27: visstrim_m10: Remove use of
 MX2_CAMERA_SWAP16.
In-Reply-To: <1332767868-2531-3-git-send-email-javier.martin@vista-silicon.com>
References: <1332767868-2531-1-git-send-email-javier.martin@vista-silicon.com>
 <1332767868-2531-3-git-send-email-javier.martin@vista-silicon.com>
Message-ID: <20120402092610.GW26642@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 26, 2012 at 03:17:47PM +0200, Javier Martin wrote:
> 
> Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Should go via the media tree.

Sascha

> ---
>  arch/arm/mach-imx/mach-imx27_visstrim_m10.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
> index 3128cfe..4db00c6 100644
> --- a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
> +++ b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
> @@ -164,7 +164,7 @@ static struct platform_device visstrim_tvp5150 = {
>  
>  
>  static struct mx2_camera_platform_data visstrim_camera = {
> -	.flags = MX2_CAMERA_CCIR | MX2_CAMERA_CCIR_INTERLACE | MX2_CAMERA_SWAP16 | MX2_CAMERA_PCLK_SAMPLE_RISING,
> +	.flags = MX2_CAMERA_CCIR | MX2_CAMERA_CCIR_INTERLACE | MX2_CAMERA_PCLK_SAMPLE_RISING,
>  	.clk = 100000,
>  };
>  
> -- 
> 1.7.0.4
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
