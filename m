From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Fri, 12 Aug 2016 09:02:21 -0400
Subject: [PATCH 1/2] ARM: exynos_defconfig: Enable SECCOMP
In-Reply-To: <1471005243-6409-1-git-send-email-k.kozlowski@samsung.com>
References: <1471005243-6409-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <54720ab1-3983-1a40-9998-e1a7b4b26db6@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 08/12/2016 08:34 AM, Krzysztof Kozlowski wrote:
> Systemd already supports seccomp.  It seems some distros are building
> systemd with seccomp, e.g. Arch on ARM, thus leading to boot errors:
> 
> systemd-logind.service: Failed at step SECCOMP spawning /usr/lib/systemd/systemd-logind: Invalid argument
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  arch/arm/configs/exynos_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
> index 81862a77dddf..5476be3be686 100644
> --- a/arch/arm/configs/exynos_defconfig
> +++ b/arch/arm/configs/exynos_defconfig
> @@ -17,6 +17,7 @@ CONFIG_PREEMPT=y
>  CONFIG_AEABI=y
>  CONFIG_HIGHMEM=y
>  CONFIG_CMA=y
> +CONFIG_SECCOMP=y
>  CONFIG_ZBOOT_ROM_TEXT=0x0
>  CONFIG_ZBOOT_ROM_BSS=0x0
>  CONFIG_ARM_APPENDED_DTB=y
> 

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
