From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 27 Sep 2016 11:06:45 +0300
Subject: [PATCH v3 2/2] ARM: exynos_defconfig: Remove old non-working MIPI
 driver
In-Reply-To: <1474014760-23173-2-git-send-email-k.kozlowski@samsung.com>
References: <1474014760-23173-1-git-send-email-k.kozlowski@samsung.com>
 <CGME20160916083252eucas1p12f57a9bc08176e10b8e07c3b421bb0ad@eucas1p1.samsung.com>
 <1474014760-23173-2-git-send-email-k.kozlowski@samsung.com>
Message-ID: <0e4921a8-ac07-8760-bd64-ec0528bbcd9a@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/09/16 11:32, Krzysztof Kozlowski wrote:
> The Exynos MIPI driver does not work anymore (it is board file only) so
> it is removed.  Remove also config options.
> 
> Cc: Inki Dae <inki.dae@samsung.com>
> Cc: Donghwa Lee <dh09.lee@samsung.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> 
> ---
> 
> This does not really depend on patch #1. The driver is dysfunctional and
> it does not work so defconfig change can be applied separately.
> 
> Changes since v2:
> 1. Remove also EXYNOS_MIPI_DSI, pointed out by Tomi Valkeinen.
> 
> Changes since v1:
> 1. New patch.
> ---
>  arch/arm/configs/exynos_defconfig | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
> index 4e484f406419..c58f6841f8aa 100644
> --- a/arch/arm/configs/exynos_defconfig
> +++ b/arch/arm/configs/exynos_defconfig
> @@ -168,8 +168,6 @@ CONFIG_DRM_PANEL_SAMSUNG_LD9040=y
>  CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0=y
>  CONFIG_DRM_NXP_PTN3460=y
>  CONFIG_DRM_PARADE_PS8622=y
> -CONFIG_EXYNOS_VIDEO=y
> -CONFIG_EXYNOS_MIPI_DSI=y
>  CONFIG_LCD_CLASS_DEVICE=y
>  CONFIG_LCD_PLATFORM=y
>  CONFIG_BACKLIGHT_PWM=y
> 

Thanks, queued these for 4.9.

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160927/8f2976d1/attachment.sig>
