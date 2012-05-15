From: riverful.kim@samsung.com (HeungJun, Kim)
Date: Tue, 15 May 2012 13:03:40 +0900
Subject: Exynos4: NURI: Remove redundant S5P_SETUP_MIPIPHY configuration
In-Reply-To: <1335785081-5398-1-git-send-email-riverful.kim@samsung.com>
References: <1335785081-5398-1-git-send-email-riverful.kim@samsung.com>
Message-ID: <002901cd324f$b644cda0$22ce68e0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ping?

> -----Original Message-----
> From: HeungJun, Kim [mailto:riverful.kim at samsung.com]
> Sent: Monday, April 30, 2012 8:25 PM
> To: linux-arm-kernel at lists.infradead.org
> Cc: linux-samsung-soc at vger.kernel.org; HeungJun, Kim; Kyungmin Park
> Subject: ARM: Exynos4: NURI: Remove redundant S5P_SETUP_MIPIPHY configuration
> 
> From: "HeungJun, Kim" <riverful.kim@samsung.com>
> 
> Signed-off-by: HeungJun, Kim <riverful.kim@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/mach-exynos/Kconfig |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
> index eb35b8a..0f9bbca 100644
> --- a/arch/arm/mach-exynos/Kconfig
> +++ b/arch/arm/mach-exynos/Kconfig
> @@ -297,7 +297,6 @@ config MACH_NURI
>  	select S5P_DEV_G2D
>  	select S5P_DEV_MFC
>  	select S5P_DEV_USB_EHCI
> -	select S5P_SETUP_MIPIPHY
>  	select S3C_DEV_USB_HSOTG
>  	select EXYNOS4_DEV_DMA
>  	select EXYNOS_DEV_DRM
> --
> 1.7.5.4
