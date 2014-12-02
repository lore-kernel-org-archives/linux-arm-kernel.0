From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Tue, 02 Dec 2014 15:23:10 +0100
Subject: [PATCH 2/2] ARM: EXYNOS: Remove ARCH_HAS_BANDGAP selection
In-Reply-To: <1417502073-6322-2-git-send-email-a.kesavan@samsung.com>
References: <1417502073-6322-1-git-send-email-a.kesavan@samsung.com>
 <1417502073-6322-2-git-send-email-a.kesavan@samsung.com>
Message-ID: <4437134.0jfvIRYXSu@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

On Tuesday, December 02, 2014 12:04:33 PM Abhilash Kesavan wrote:
> On removing the samsung thermal driver dependency on ARCH_HAS_BANDGAP,
> selection of this symbol becomes redundant.
> 
> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>

This has also a nice side-effect of removing TI_SOC_THERMAL availability
from Exynos only kernel configurations.

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  arch/arm/mach-exynos/Kconfig |    1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
> index e4a00ba..6ddfce7 100644
> --- a/arch/arm/mach-exynos/Kconfig
> +++ b/arch/arm/mach-exynos/Kconfig
> @@ -9,7 +9,6 @@
>  
>  menuconfig ARCH_EXYNOS
>  	bool "Samsung EXYNOS" if ARCH_MULTI_V7
> -	select ARCH_HAS_BANDGAP
>  	select ARCH_HAS_HOLES_MEMORYMODEL
>  	select ARCH_REQUIRE_GPIOLIB
>  	select ARM_AMBA
