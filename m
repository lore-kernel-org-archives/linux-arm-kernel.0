From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 30 Jan 2013 21:04:55 +0800
Subject: [PATCH 2/2] ARM: imx_v6_v7_defconfig: Add VPU support
In-Reply-To: <1359474553-8949-2-git-send-email-fabio.estevam@freescale.com>
References: <1359474553-8949-1-git-send-email-fabio.estevam@freescale.com>
 <1359474553-8949-2-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20130130130453.GC2757@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 29, 2013 at 01:49:13PM -0200, Fabio Estevam wrote:
> Let the VPU driver be built by default.
> 
Do we have any imx_v6_v7 platform supported by VPU driver today?

Shawn

> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/configs/imx_v6_v7_defconfig |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
> index 6966713..83822d9 100644
> --- a/arch/arm/configs/imx_v6_v7_defconfig
> +++ b/arch/arm/configs/imx_v6_v7_defconfig
> @@ -160,6 +160,8 @@ CONFIG_MEDIA_CAMERA_SUPPORT=y
>  CONFIG_SOC_CAMERA=y
>  CONFIG_SOC_CAMERA_OV2640=y
>  CONFIG_VIDEO_MX3=y
> +CONFIG_V4L_MEM2MEM_DRIVERS=y
> +CONFIG_VIDEO_CODA=y
>  CONFIG_FB=y
>  CONFIG_LCD_PLATFORM=y
>  CONFIG_BACKLIGHT_LCD_SUPPORT=y
> -- 
> 1.7.9.5
> 
> 
