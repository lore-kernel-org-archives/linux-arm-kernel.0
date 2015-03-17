From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Tue, 17 Mar 2015 19:54:20 +0100
Subject: [PATCH 1/1] ARM: exynos_defconfig: Enable HDMI support
In-Reply-To: <1423244567-24463-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1423244567-24463-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <CABxcv=mMD=X=EKOC2sGXcDwMeOmoO6cmVAu=roV_AVqUwG+pXg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Kukjin,

On Fri, Feb 6, 2015 at 6:42 PM, Javier Martinez Canillas
<javier.martinez@collabora.co.uk> wrote:
> Many Exynos boards have an HDMI port so enable Exynos DRM HDMI support.
>
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> ---
>
> Exynos DRM HDMI has some issues that were fixed by Andrzej's [0] series.
> So now is safe to HDMI support for Exynos boards.
>
> [0]: https://lkml.org/lkml/2015/2/5/265
>
>  arch/arm/configs/exynos_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
> index 70e5d0bdb4e4..e44da52e5223 100644
> --- a/arch/arm/configs/exynos_defconfig
> +++ b/arch/arm/configs/exynos_defconfig
> @@ -120,6 +120,7 @@ CONFIG_REGULATOR_S2MPS11=y
>  CONFIG_REGULATOR_S5M8767=y
>  CONFIG_REGULATOR_TPS65090=y
>  CONFIG_DRM=y
> +CONFIG_DRM_EXYNOS_HDMI=y
>  CONFIG_DRM_BRIDGE=y
>  CONFIG_DRM_PTN3460=y
>  CONFIG_DRM_PS8622=y
> --

It seems you missed this patch when picking the exynos_defconfig patches.

Best regards,
Javier
