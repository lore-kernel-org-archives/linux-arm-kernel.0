From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 21 Dec 2017 12:13:22 +0100
Subject: [PATCH] arm64: defconfig: enable ARM_ARMADA_37XX_CPUFREQ
In-Reply-To: <20171215153532.29924-1-gregory.clement@free-electrons.com>
 (Gregory CLEMENT's message of "Fri, 15 Dec 2017 16:35:32 +0100")
References: <20171215153532.29924-1-gregory.clement@free-electrons.com>
Message-ID: <87a7ycfi5p.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
 
 On ven., d?c. 15 2017, Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:

> Add the cpu frequency scaling support for Armada 37xx by default, this
> should allow a better coverage in kernel continuous integration tests.
>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Applied on mvebu/arm64

Gregory

> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 6356c6da34ea..a4222de46500 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -99,6 +99,7 @@ CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
>  CONFIG_ARM_CPUIDLE=y
>  CONFIG_CPU_FREQ=y
>  CONFIG_CPUFREQ_DT=y
> +CONFIG_ARM_ARMADA_37XX_CPUFREQ=y
>  CONFIG_ARM_BIG_LITTLE_CPUFREQ=y
>  CONFIG_ARM_SCPI_CPUFREQ=y
>  CONFIG_ACPI_CPPC_CPUFREQ=m
> -- 
> 2.15.1
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
