From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 1 Sep 2014 10:13:59 +0530
Subject: [PATCH] ARM: configs: Enable cpufreq-cpu0 for multi_v7_defconfig
In-Reply-To: <1409486979-26869-1-git-send-email-broonie@kernel.org>
References: <1409486979-26869-1-git-send-email-broonie@kernel.org>
Message-ID: <CAKohpo=amz9+7Q2bF_hqKKw+RixLngi-xwR8GU9L1pi6kvYnqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31 August 2014 17:39, Mark Brown <broonie@kernel.org> wrote:
> Many boards share the cpufreq-cpu0 driver meaning that if we enable it in
> multi_v7_defconfig we can get a reasonable amount of functional utility for
> systems and test coverage for a fairly small increase in kernel size.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  arch/arm/configs/multi_v7_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index 05c0e7c789df..9799e9d2e222 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -414,3 +414,5 @@ CONFIG_DEBUG_FS=y
>  CONFIG_MAGIC_SYSRQ=y
>  CONFIG_LOCKUP_DETECTOR=y
>  CONFIG_CRYPTO_DEV_TEGRA_AES=y
> +CONFIG_CPU_FREQ=y
> +CONFIG_GENERIC_CPUFREQ_CPU0=y

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
