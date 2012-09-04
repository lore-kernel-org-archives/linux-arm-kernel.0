From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 05 Sep 2012 07:10:00 +0900
Subject: [PATCH 1/2] ARM: exynos: delete redundant HAVE_SCHED_CLOCK option
 in Kconfig
In-Reply-To: <1346406296-16223-1-git-send-email-Barry.Song@csr.com>
References: <1346406296-16223-1-git-send-email-Barry.Song@csr.com>
Message-ID: <227101cd8aea$06a06e10$13e14a30$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Barry Song wrote:
> 
> From: Barry Song <Baohua.Song@csr.com>
> 
> Signed-off-by: Barry Song <Baohua.Song@csr.com>

Acked-by: Kukjin Kim <kgene.kim@samsung.com>

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

> ---
>  arch/arm/mach-exynos/Kconfig |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
> index b5b4c8c..3fd4ab3 100644
> --- a/arch/arm/mach-exynos/Kconfig
> +++ b/arch/arm/mach-exynos/Kconfig
> @@ -243,7 +243,6 @@ config MACH_UNIVERSAL_C210
>  	select CPU_EXYNOS4210
>  	select S5P_HRT
>  	select CLKSRC_MMIO
> -	select HAVE_SCHED_CLOCK
>  	select S5P_GPIO_INT
>  	select S5P_DEV_FIMC0
>  	select S5P_DEV_FIMC1
> --
> 1.7.0.4
