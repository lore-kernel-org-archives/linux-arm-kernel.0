From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 12 Oct 2015 21:50:28 +0800
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Select HDMI audio support
In-Reply-To: <1444654124-8248-1-git-send-email-festevam@gmail.com>
References: <1444654124-8248-1-git-send-email-festevam@gmail.com>
Message-ID: <20151012135028.GC18611@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 12, 2015 at 09:48:44AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Select CONFIG_DRM_DW_HDMI_AHB_AUDIO so that we have HDMI audio
> supported by default.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> Shawn,
> 
> Should this one go via Russell's tree, which contains the patches
> that add HDMI audio support?

It's just a defconfig update, and we can wait for Russell's driver
support hit mainline first.

Shawn

> 
>  arch/arm/configs/imx_v6_v7_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
> index 4187f69..f5ca938 100644
> --- a/arch/arm/configs/imx_v6_v7_defconfig
> +++ b/arch/arm/configs/imx_v6_v7_defconfig
> @@ -224,6 +224,7 @@ CONFIG_SOC_CAMERA_OV2640=y
>  CONFIG_IMX_IPUV3_CORE=y
>  CONFIG_DRM=y
>  CONFIG_DRM_PANEL_SIMPLE=y
> +CONFIG_DRM_DW_HDMI_AHB_AUDIO=y
>  CONFIG_DRM_IMX=y
>  CONFIG_DRM_IMX_FB_HELPER=y
>  CONFIG_DRM_IMX_PARALLEL_DISPLAY=y
> -- 
> 1.9.1
> 
