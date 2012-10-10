From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 10 Oct 2012 10:51:22 +0200
Subject: [PATCH] ARM: imx: configs: Enable CONFIG_MEDIA_CAMERA_SUPPORT
In-Reply-To: <1349631857-31556-1-git-send-email-festevam@gmail.com>
References: <1349631857-31556-1-git-send-email-festevam@gmail.com>
Message-ID: <20121010085122.GT27665@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 07, 2012 at 02:44:17PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Since commit b4c184e5 (edia] media: reorganize the main Kconfig items),
> it is necessary to select CONFIG_MEDIA_CAMERA_SUPPORT in order to be able
> to use the SoC camera drivers.
> 
> Select CONFIG_MEDIA_CAMERA_SUPPORT so that we can use mx2-camera/mx3-camera
> by default as previously.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied, thanks

Sascha

> ---
>  arch/arm/configs/imx_v4_v5_defconfig |    1 +
>  arch/arm/configs/imx_v6_v7_defconfig |    1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/arch/arm/configs/imx_v4_v5_defconfig b/arch/arm/configs/imx_v4_v5_defconfig
> index 78ed575..d100401 100644
> --- a/arch/arm/configs/imx_v4_v5_defconfig
> +++ b/arch/arm/configs/imx_v4_v5_defconfig
> @@ -121,6 +121,7 @@ CONFIG_REGULATOR_MC13892=y
>  CONFIG_MEDIA_SUPPORT=y
>  CONFIG_VIDEO_DEV=y
>  CONFIG_V4L_PLATFORM_DRIVERS=y
> +CONFIG_MEDIA_CAMERA_SUPPORT=y
>  CONFIG_SOC_CAMERA=y
>  CONFIG_SOC_CAMERA_OV2640=y
>  CONFIG_VIDEO_MX2=y
> diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
> index 66aa7a6..fcb4b62 100644
> --- a/arch/arm/configs/imx_v6_v7_defconfig
> +++ b/arch/arm/configs/imx_v6_v7_defconfig
> @@ -151,6 +151,7 @@ CONFIG_REGULATOR_MC13892=y
>  CONFIG_MEDIA_SUPPORT=y
>  CONFIG_VIDEO_DEV=y
>  CONFIG_V4L_PLATFORM_DRIVERS=y
> +CONFIG_MEDIA_CAMERA_SUPPORT=y
>  CONFIG_SOC_CAMERA=y
>  CONFIG_SOC_CAMERA_OV2640=y
>  CONFIG_VIDEO_MX3=y
> -- 
> 1.7.9.5
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
