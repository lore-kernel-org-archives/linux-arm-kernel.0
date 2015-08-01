From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Sat, 1 Aug 2015 16:20:13 +0530
Subject: [PATCH v3 4/5] cpufreq: exynos: remove Exynos4x12 specific
 cpufreq driver support
In-Reply-To: <1438368557-2352-5-git-send-email-b.zolnierkie@samsung.com>
References: <1438368557-2352-1-git-send-email-b.zolnierkie@samsung.com>
 <1438368557-2352-5-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <20150801105013.GG899@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc'ing Rafael, please keep him in loop for such patches and better use
get_maintainers to get the cc list automatically.

On 31-07-15, 20:49, Bartlomiej Zolnierkiewicz wrote:
> Exynos4x12 based platforms have switched over to use generic
> cpufreq driver for cpufreq functionality.  So the Exynos
> specific cpufreq support for these platforms can be removed.
> 
> Also once Exynos4x12 based platforms support have been removed
> the shared exynos-cpufreq driver is no longer needed and can
> be deleted.
> 
> Based on the earlier work by Thomas Abraham.
> 
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Thomas Abraham <thomas.ab@samsung.com>
> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  drivers/cpufreq/Kconfig.arm          |  38 ------
>  drivers/cpufreq/Makefile             |   2 -
>  drivers/cpufreq/exynos-cpufreq.c     | 236 -----------------------------------
>  drivers/cpufreq/exynos-cpufreq.h     |  72 -----------
>  drivers/cpufreq/exynos4x12-cpufreq.c | 236 -----------------------------------
>  5 files changed, 584 deletions(-)
>  delete mode 100644 drivers/cpufreq/exynos-cpufreq.c
>  delete mode 100644 drivers/cpufreq/exynos-cpufreq.h
>  delete mode 100644 drivers/cpufreq/exynos4x12-cpufreq.c

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
