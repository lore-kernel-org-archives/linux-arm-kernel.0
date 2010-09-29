From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 29 Sep 2010 21:36:59 +0900
Subject: [PATCH v3 3/3] ARM: S5PC100/S5PC110/S5PC210: Remove duplicated
	selete PLAT_S5P at each ARCH_S5P series
In-Reply-To: <20100929014724.GA823@july>
References: <20100929014724.GA823@july>
Message-ID: <001c01cb5fd3$0506a1d0$0f13e570$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kyungmin Park wrote:
> 
> From: Kyungmin Park <kyungmin.park@samsung.com>
> 
> It's already selected whtn S5P series. So remove it.
> 
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/mach-s5pc100/Kconfig |    1 -
>  arch/arm/mach-s5pv210/Kconfig |    1 -
>  arch/arm/mach-s5pv310/Kconfig |    1 -
>  3 files changed, 0 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-s5pc100/Kconfig b/arch/arm/mach-s5pc100/Kconfig
> index 77ae4bf..b8fbf2f 100644
> --- a/arch/arm/mach-s5pc100/Kconfig
> +++ b/arch/arm/mach-s5pc100/Kconfig
> @@ -9,7 +9,6 @@ if ARCH_S5PC100
> 
>  config CPU_S5PC100
>  	bool
> -	select PLAT_S5P
>  	select S5P_EXT_INT
>  	select S3C_PL330_DMA
>  	help
> diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
> index 97e4f11..6ddc232 100644
> --- a/arch/arm/mach-s5pv210/Kconfig
> +++ b/arch/arm/mach-s5pv210/Kconfig
> @@ -11,7 +11,6 @@ if ARCH_S5PV210
> 
>  config CPU_S5PV210
>  	bool
> -	select PLAT_S5P
>  	select S3C_PL330_DMA
>  	select S5P_EXT_INT
>  	help
> diff --git a/arch/arm/mach-s5pv310/Kconfig b/arch/arm/mach-s5pv310/Kconfig
> index ec8b350..4839fef 100644
> --- a/arch/arm/mach-s5pv310/Kconfig
> +++ b/arch/arm/mach-s5pv310/Kconfig
> @@ -11,7 +11,6 @@ if ARCH_S5PV310
> 
>  config CPU_S5PV310
>  	bool
> -	select PLAT_S5P
>  	help
>  	  Enable S5PV310 CPU support
> 
> --

Ok..will apply.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
