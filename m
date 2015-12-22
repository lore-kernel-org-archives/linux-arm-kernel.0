From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 22 Dec 2015 20:21:55 +0800
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Enable GPU support
In-Reply-To: <1450723442-1518-1-git-send-email-festevam@gmail.com>
References: <1450723442-1518-1-git-send-email-festevam@gmail.com>
Message-ID: <20151222122154.GD26290@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 21, 2015 at 04:44:02PM -0200, Fabio Estevam wrote:
> Select CONFIG_DRM_ETNAVIV, so that GPU support can be enabled by default.
> 
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---
>  arch/arm/configs/imx_v6_v7_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
> index 2d5253d..be08ce7 100644
> --- a/arch/arm/configs/imx_v6_v7_defconfig
> +++ b/arch/arm/configs/imx_v6_v7_defconfig
> @@ -231,6 +231,7 @@ CONFIG_DRM_IMX_PARALLEL_DISPLAY=y
>  CONFIG_DRM_IMX_TVE=y
>  CONFIG_DRM_IMX_LDB=y
>  CONFIG_DRM_IMX_HDMI=y
> +CONFIG_DRM_ETNAVIV=y

I do not have this Kconfig option on my tree yet.

Shawn

>  CONFIG_FB_MXS=y
>  CONFIG_LCD_CLASS_DEVICE=y
>  CONFIG_LCD_L4F00242T03=y
> -- 
> 1.9.1
> 
> 
