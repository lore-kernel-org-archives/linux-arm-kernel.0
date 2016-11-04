From: alim.akhtar@samsung.com (Alim Akhtar)
Date: Fri, 04 Nov 2016 19:01:02 +0530
Subject: [4/4] ARM: EXYNOS: Remove unused soc_is_exynos{4,5}
In-Reply-To: <1478230764-13748-5-git-send-email-pankaj.dubey@samsung.com>
References: <1478230764-13748-5-git-send-email-pankaj.dubey@samsung.com>
 <CGME20161104133241epcas4p4808a1670bfe21ad445e6d54eb61b79a7@epcas4p4.samsung.com>
Message-ID: <581C8D96.4040507@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pankaj,

On 11/04/2016 09:09 AM, Pankaj Dubey wrote:
> As no more user of soc_is_exynos{4,5} we can safely remove them.
>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---

Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

Also I have complied tested this series, looks good.

>   arch/arm/mach-exynos/common.h | 5 -----
>   1 file changed, 5 deletions(-)
>
> diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
> index 9424a8a..d19064b 100644
> --- a/arch/arm/mach-exynos/common.h
> +++ b/arch/arm/mach-exynos/common.h
> @@ -105,11 +105,6 @@ IS_SAMSUNG_CPU(exynos5800, EXYNOS5800_SOC_ID, EXYNOS5_SOC_MASK)
>   # define soc_is_exynos5800()	0
>   #endif
>
> -#define soc_is_exynos4() (soc_is_exynos4210() || soc_is_exynos4212() || \
> -			  soc_is_exynos4412())
> -#define soc_is_exynos5() (soc_is_exynos5250() || soc_is_exynos5410() || \
> -			  soc_is_exynos5420() || soc_is_exynos5800())
> -
>   extern u32 cp15_save_diag;
>   extern u32 cp15_save_power;
>
>
