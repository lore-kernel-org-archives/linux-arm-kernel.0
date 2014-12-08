From: l.majewski@samsung.com (Lukasz Majewski)
Date: Mon, 08 Dec 2014 10:44:12 +0100
Subject: [PATCH 2/2] ARM: EXYNOS: Remove ARCH_HAS_BANDGAP selection
In-Reply-To: <1417502073-6322-2-git-send-email-a.kesavan@samsung.com>
References: <1417502073-6322-1-git-send-email-a.kesavan@samsung.com>
 <1417502073-6322-2-git-send-email-a.kesavan@samsung.com>
Message-ID: <20141208104412.76c3023d@amdc2363>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Abhilash,

> On removing the samsung thermal driver dependency on ARCH_HAS_BANDGAP,
> selection of this symbol becomes redundant.
> 
> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> ---
>  arch/arm/mach-exynos/Kconfig |    1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/mach-exynos/Kconfig
> b/arch/arm/mach-exynos/Kconfig index e4a00ba..6ddfce7 100644
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

Acked-by: Lukasz Majewski <l.majewski@samsung.com>

-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
