From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Fri, 12 Aug 2016 09:03:50 -0400
Subject: [PATCH 2/2] ARM: multi_v7_defconfig: Enable SECCOMP
In-Reply-To: <1471005243-6409-2-git-send-email-k.kozlowski@samsung.com>
References: <1471005243-6409-1-git-send-email-k.kozlowski@samsung.com>
 <1471005243-6409-2-git-send-email-k.kozlowski@samsung.com>
Message-ID: <ddcc04de-1428-3b38-70cd-e0ce294a0103@osg.samsung.com>
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
>  arch/arm/configs/multi_v7_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index 7db8dce3da5f..0ccaa519f588 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -126,6 +126,7 @@ CONFIG_SMP=y
>  CONFIG_NR_CPUS=16
>  CONFIG_HIGHPTE=y
>  CONFIG_CMA=y
> +CONFIG_SECCOMP=y
>  CONFIG_ARM_APPENDED_DTB=y
>  CONFIG_ARM_ATAG_DTB_COMPAT=y
>  CONFIG_KEXEC=y
> 

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
