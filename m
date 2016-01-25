From: l.stach@pengutronix.de (Lucas Stach)
Date: Mon, 25 Jan 2016 10:50:09 +0100
Subject: [PATCH v2] ARM: imx_v6_v7_defconfig: Enable GPU support
In-Reply-To: <1453682984-5785-1-git-send-email-festevam@gmail.com>
References: <1453682984-5785-1-git-send-email-festevam@gmail.com>
Message-ID: <1453715409.4368.0.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Sonntag, den 24.01.2016, 22:49 -0200 schrieb Fabio Estevam:
> Select CONFIG_DRM_ETNAVIV, so that GPU support can be enabled by default.
> 
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Acked-by: Lucas Stach <l.stach@pengutronix.de>

> ---
> Changes since v1:
> - Rebase against 4.5-rc1
> 
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
>  CONFIG_FB_MXS=y
>  CONFIG_LCD_CLASS_DEVICE=y
>  CONFIG_LCD_L4F00242T03=y

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |
