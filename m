From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 15 Dec 2017 16:15:32 +0530
Subject: [PATCH] arm64: defconfig: Select schedutil as default cpufreq
 governor
In-Reply-To: <af12e002bc165844101830c0eb00e283b536a879.1510813288.git.viresh.kumar@linaro.org>
References: <af12e002bc165844101830c0eb00e283b536a879.1510813288.git.viresh.kumar@linaro.org>
Message-ID: <20171215104532.GA24314@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16-11-17, 11:51, Viresh Kumar wrote:
> Currently performance governor is getting selected by default, which is
> surely not a very good choice as its pretty much power hungry.
> 
> Select schedutil instead.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 34480e9af2e7..9424a7aafdb2 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -93,6 +93,7 @@ CONFIG_HIBERNATION=y
>  CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
>  CONFIG_ARM_CPUIDLE=y
>  CONFIG_CPU_FREQ=y
> +CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL=y
>  CONFIG_CPUFREQ_DT=y
>  CONFIG_ARM_BIG_LITTLE_CPUFREQ=y
>  CONFIG_ARM_SCPI_CPUFREQ=y

Ping !!

-- 
viresh
