From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 8 Nov 2018 10:09:42 +0000
Subject: [PATCH 2/9] arm64: defconfig: Drop ARM_BIG_LITTLE_CPUFREQ
In-Reply-To: <596a4b64-e2ef-878d-0873-dd59d14c2d85@free.fr>
References: <8b49a92b-ca92-1fca-cd09-3bcd7a3dcbb9@free.fr>
 <596a4b64-e2ef-878d-0873-dd59d14c2d85@free.fr>
Message-ID: <20181108100941.f7vv5pivq24vz7kx@salmiak>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 07, 2018 at 09:14:57PM +0100, Marc Gonzalez wrote:
> Commit a7314405d83c ("drop ARM_BIG_LITTLE_CPUFREQ support for ARM64")
> 
> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>

Please elaborate the situation in the commit message, e.g.

  The big.LITTLE cpufreq driver has been banned for arm64 since commit:

  a7314405d83c ("drop ARM_BIG_LITTLE_CPUFREQ support for ARM64")

  ... so it can be removed from defconfig.

With that:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/configs/defconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index f786c95504d3..8d6878c1e794 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -107,7 +107,6 @@ CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y
>  CONFIG_CPUFREQ_DT=y
>  CONFIG_ACPI_CPPC_CPUFREQ=m
>  CONFIG_ARM_ARMADA_37XX_CPUFREQ=y
> -CONFIG_ARM_BIG_LITTLE_CPUFREQ=y
>  CONFIG_ARM_SCPI_CPUFREQ=y
>  CONFIG_ARM_TEGRA186_CPUFREQ=y
>  CONFIG_ARM_SCPI_PROTOCOL=y
> -- 
> 2.17.1
