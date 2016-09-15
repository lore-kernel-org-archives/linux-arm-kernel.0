From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 15 Sep 2016 11:02:31 +0100
Subject: [PATCH] arm64: Enable HIBERNATION in defconfig
In-Reply-To: <1473932534-2710-1-git-send-email-catalin.marinas@arm.com>
References: <1473932534-2710-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <20160915100231.GG2492@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 15, 2016 at 10:42:14AM +0100, Catalin Marinas wrote:
> This patch adds CONFIG_HIBERNATION to the arm64 defconfig.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index eadf4855ad2d..91a7592029e3 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -80,6 +80,7 @@ CONFIG_KEXEC=y
>  # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
>  CONFIG_COMPAT=y
>  CONFIG_CPU_IDLE=y
> +CONFIG_HIBERNATION=y
>  CONFIG_ARM_CPUIDLE=y
>  CONFIG_CPU_FREQ=y
>  CONFIG_ARM_BIG_LITTLE_CPUFREQ=y

Or maybe it could go through arm-soc as it seems Arnd has picked up a
few other defconfig patches.

Thanks.

-- 
Catalin
