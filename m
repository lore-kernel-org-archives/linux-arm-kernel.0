From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 29 Sep 2014 02:58:25 -0700
Subject: [PATCHv3 3/4] ARM: exynos: Add exynos3250 compatible to use
 generic cpufreq driver
In-Reply-To: <1411628707-8496-4-git-send-email-cw00.choi@samsung.com>
References: <1411628707-8496-1-git-send-email-cw00.choi@samsung.com>
 <1411628707-8496-4-git-send-email-cw00.choi@samsung.com>
Message-ID: <CAKohpokXNEYZBqsKyJDMUCZA7BY_E0=G5eVmTx_cBKvAyoSi9w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25 September 2014 00:05, Chanwoo Choi <cw00.choi@samsung.com> wrote:
> This patch add exynos3250 compatible string to exynos_cpufreq_matches
> for supporting generic cpufreq driver on Exynos3250.
>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Cc: Thomas Abraham <thomas.ab@samsung.com>
> ---
>  arch/arm/mach-exynos/exynos.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
> index 8923d37..1318d69 100644
> --- a/arch/arm/mach-exynos/exynos.c
> +++ b/arch/arm/mach-exynos/exynos.c
> @@ -285,6 +285,7 @@ static const struct of_device_id exynos_cpufreq_matches[] = {
>         { .compatible = "samsung,exynos5420", .data = "arm-bL-cpufreq-dt" },
>         { .compatible = "samsung,exynos5250", .data = "cpufreq-cpu0" },
>         { .compatible = "samsung,exynos4210", .data = "cpufreq-cpu0" },
> +       { .compatible = "samsung,exynos3250", .data = "cpufreq-cpu0" },

cpufreq-cpu0 is renamed to cpufreq-dt now.
