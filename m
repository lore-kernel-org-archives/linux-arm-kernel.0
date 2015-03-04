From: horms@verge.net.au (Simon Horman)
Date: Thu, 5 Mar 2015 07:55:23 +0900
Subject: [PATCH 2/2] ARM: multi_v7_defconfig: Enable shmobile
 r8a7778/bockw platform
In-Reply-To: <1425471261-25110-3-git-send-email-geert+renesas@glider.be>
References: <1425471261-25110-1-git-send-email-geert+renesas@glider.be>
 <1425471261-25110-3-git-send-email-geert+renesas@glider.be>
Message-ID: <20150304225522.GB2470@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 04, 2015 at 01:14:21PM +0100, Geert Uytterhoeven wrote:
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>   - Derived from r8a7778-bockw.dtb using
>     https://github.com/geertu/linux-scripts/blob/master/linux-config-from-dt
>   - Not tested on bockw due to lack of hardware
> ---
>  arch/arm/configs/multi_v7_defconfig | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index b7e6b6fba5e0f0d6..fa1ecbcfe08cb127 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -67,6 +67,7 @@ CONFIG_ARCH_EMEV2=y
>  CONFIG_ARCH_R7S72100=y
>  CONFIG_ARCH_R8A73A4=y
>  CONFIG_ARCH_R8A7740=y
> +CONFIG_ARCH_R8A7778=y
>  CONFIG_ARCH_R8A7779=y
>  CONFIG_ARCH_R8A7790=y
>  CONFIG_ARCH_R8A7791=y
> @@ -377,6 +378,7 @@ CONFIG_V4L_MEM2MEM_DRIVERS=y
>  CONFIG_VIDEO_RENESAS_VSP1=m
>  # CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set
>  CONFIG_VIDEO_ADV7180=m
> +CONFIG_VIDEO_ML86V7667=m
>  CONFIG_DRM=y
>  CONFIG_DRM_RCAR_DU=m
>  CONFIG_DRM_TEGRA=y
> @@ -493,6 +495,7 @@ CONFIG_RTC_DRV_TWL4030=y
>  CONFIG_RTC_DRV_TPS6586X=y
>  CONFIG_RTC_DRV_TPS65910=y
>  CONFIG_RTC_DRV_S35390A=m
> +CONFIG_RTC_DRV_RX8581=m
>  CONFIG_RTC_DRV_EM3027=y
>  CONFIG_RTC_DRV_PL031=y
>  CONFIG_RTC_DRV_VT8500=y
> -- 
> 1.9.1
> 
