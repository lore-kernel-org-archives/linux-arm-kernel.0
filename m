From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 18 Dec 2013 10:09:27 +0530
Subject: [PATCH 08/11] cpufreq: exynos: move definitions for
 exynos-cpufreq into drivers/cpufreq/
In-Reply-To: <116601cefb1e$84396e30$8cac4a90$@kernel.org>
References: <116601cefb1e$84396e30$8cac4a90$@kernel.org>
Message-ID: <CAOh2x=mp=Ft0YK5PfRDGH_VVjbUS8ps+PhbmH6Z31wwA1rYRag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 17, 2013 at 5:22 PM,  <kgene@kernel.org> wrote:
> From: Kukjin Kim <kgene.kim@samsung.com>
>
> This moves regarding exynos-cpufreq definitions into drivers/cpufreq/
> exynos-cpufreq.h because they are used only for the cpufreq driver.
>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
>  arch/arm/mach-exynos/include/mach/regs-clock.h |   21 ---------------------
>  drivers/cpufreq/exynos-cpufreq.h               |   22
> ++++++++++++++++++++++
>  drivers/cpufreq/exynos4210-cpufreq.c           |    2 --
>  drivers/cpufreq/exynos4x12-cpufreq.c           |    2 --
>  drivers/cpufreq/exynos5250-cpufreq.c           |    1 -
>  5 files changed, 22 insertions(+), 26 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
