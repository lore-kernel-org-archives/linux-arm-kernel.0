From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 7 Sep 2016 11:14:13 +0300
Subject: [PATCH v2 2/2] ARM: exynos_defconfig: Remove old non-working MIPI
 driver
In-Reply-To: <1472730589-18683-2-git-send-email-k.kozlowski@samsung.com>
References: <1472730589-18683-1-git-send-email-k.kozlowski@samsung.com>
 <1472730589-18683-2-git-send-email-k.kozlowski@samsung.com>
Message-ID: <2b3688bb-8dcb-24d4-8112-a0cc56573e48@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/09/16 14:49, Krzysztof Kozlowski wrote:
> The Exynos MIPI driver does not work anymore (it is board file only) so
> it is removed.  Remove also config option.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> 
> ---
> 
> Changes since v1:
> 1. New patch.
> ---
>  arch/arm/configs/exynos_defconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
> index 4e484f406419..fea8edef1534 100644
> --- a/arch/arm/configs/exynos_defconfig
> +++ b/arch/arm/configs/exynos_defconfig
> @@ -168,7 +168,6 @@ CONFIG_DRM_PANEL_SAMSUNG_LD9040=y
>  CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0=y
>  CONFIG_DRM_NXP_PTN3460=y
>  CONFIG_DRM_PARADE_PS8622=y
> -CONFIG_EXYNOS_VIDEO=y
>  CONFIG_EXYNOS_MIPI_DSI=y

EXYNOS_MIPI_DSI too?

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160907/701488d9/attachment-0001.sig>
