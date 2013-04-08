From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 09 Apr 2013 03:21:21 +0900
Subject: [PATCH] ARM: EXYNOS: remove "config EXYNOS_DEV_DRM"
In-Reply-To: <1365432910.1830.105.camel@x61.thuisdomein>
References: <1365432910.1830.105.camel@x61.thuisdomein>
Message-ID: <51630AA1.8060207@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/08/13 23:55, Paul Bolle wrote:
> The only user of Kconfig symbol EXYNOS_DEV_DRM was removed in commit
> 0a9d5ac307aefbb2c772537d3fe7f75046d563ac ("ARM: EXYNOS: removing
> exynos-drm device registration from non-dt platforms"). It is safe to
> remove this symbol too.
>
> Signed-off-by: Paul Bolle<pebolle@tiscali.nl>
> ---
> Only "git grep" tested.
>
>   arch/arm/mach-exynos/Kconfig | 10 ----------
>   1 file changed, 10 deletions(-)
>
> diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
> index 70f94c8..99e7142 100644
> --- a/arch/arm/mach-exynos/Kconfig
> +++ b/arch/arm/mach-exynos/Kconfig
> @@ -95,11 +95,6 @@ config EXYNOS4_DEV_AHCI
>   	help
>   	  Compile in platform device definitions for AHCI
>
> -config EXYNOS_DEV_DRM
> -	bool
> -	help
> -	  Compile in platform device definitions for core DRM device
> -
>   config EXYNOS4_SETUP_FIMD0
>   	bool
>   	help
> @@ -199,7 +194,6 @@ config MACH_SMDKV310
>   	select EXYNOS4_SETUP_SDHCI
>   	select EXYNOS4_SETUP_USB_PHY
>   	select EXYNOS_DEV_DMA
> -	select EXYNOS_DEV_DRM
>   	select EXYNOS_DEV_SYSMMU
>   	select S3C24XX_PWM
>   	select S3C_DEV_HSMMC
> @@ -253,7 +247,6 @@ config MACH_UNIVERSAL_C210
>   	select EXYNOS4_SETUP_SDHCI
>   	select EXYNOS4_SETUP_USB_PHY
>   	select EXYNOS_DEV_DMA
> -	select EXYNOS_DEV_DRM
>   	select EXYNOS_DEV_SYSMMU
>   	select HAVE_SCHED_CLOCK
>   	select S3C_DEV_HSMMC
> @@ -294,7 +287,6 @@ config MACH_NURI
>   	select EXYNOS4_SETUP_SDHCI
>   	select EXYNOS4_SETUP_USB_PHY
>   	select EXYNOS_DEV_DMA
> -	select EXYNOS_DEV_DRM
>   	select S3C_DEV_HSMMC
>   	select S3C_DEV_HSMMC2
>   	select S3C_DEV_HSMMC3
> @@ -330,7 +322,6 @@ config MACH_ORIGEN
>   	select EXYNOS4_SETUP_SDHCI
>   	select EXYNOS4_SETUP_USB_PHY
>   	select EXYNOS_DEV_DMA
> -	select EXYNOS_DEV_DRM
>   	select EXYNOS_DEV_SYSMMU
>   	select S3C24XX_PWM
>   	select S3C_DEV_HSMMC
> @@ -366,7 +357,6 @@ config MACH_SMDK4212
>   	select EXYNOS4_SETUP_SDHCI
>   	select EXYNOS4_SETUP_USB_PHY
>   	select EXYNOS_DEV_DMA
> -	select EXYNOS_DEV_DRM
>   	select EXYNOS_DEV_SYSMMU
>   	select S3C24XX_PWM
>   	select S3C_DEV_HSMMC2

Applied, thanks.

- Kukjin
