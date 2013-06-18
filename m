From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 18 Jun 2013 08:48:41 +0530
Subject: [PATCH v2 31/38] cpufreq: exynos4x12: Remove check for
 SOC_EXYNOS4412
In-Reply-To: <1371486863-12398-32-git-send-email-t.figa@samsung.com>
References: <1371486863-12398-1-git-send-email-t.figa@samsung.com>
 <1371486863-12398-32-git-send-email-t.figa@samsung.com>
Message-ID: <CAKohpomufhbjafoekVcW8HZkMHTp7Ew-wHJQ45TrCg6tBExVqQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 June 2013 22:04, Tomasz Figa <t.figa@samsung.com> wrote:
> Since SOC_EXYNOS4412 Kconfig symbol has been removed, it is enough to
> check for SOC_EXYNOS4212 for both SoCs from Exynos4x12 series.
>
> Cc: linux-pm at vger.kernel.org
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/cpufreq/Kconfig.arm | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Looks good. You want it to get via samsung tree or cpufreq? I think
all cpufreq related patches should go through cpufreq unless there
is a real dependency on samsung tree.
