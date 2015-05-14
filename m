From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 14 May 2015 10:33:12 +0530
Subject: [PATCH 6/6] cpufreq: exynos: remove Exynos4210 specific cpufreq
 driver support
In-Reply-To: <1428079429-4252-7-git-send-email-b.zolnierkie@samsung.com>
References: <'@samsung.com>
 <1428079429-4252-1-git-send-email-b.zolnierkie@samsung.com>
 <1428079429-4252-7-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <20150514050312.GA26341@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03-04-15, 18:43, Bartlomiej Zolnierkiewicz wrote:
> From: Thomas Abraham <thomas.ab@samsung.com>
> 
> Exynos4210 based platforms have switched over to use generic
> cpufreq driver for cpufreq functionality. So the Exynos
> specific cpufreq support for these platforms can be removed.
> 
> Changes by Bartlomiej:
> - dropped Exynos5250 support removal for now
> - updated exynos-cpufreq.[c,h]
> 
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  drivers/cpufreq/Kconfig.arm          |   11 --
>  drivers/cpufreq/Makefile             |    1 -
>  drivers/cpufreq/exynos-cpufreq.c     |    5 +-
>  drivers/cpufreq/exynos-cpufreq.h     |    9 --
>  drivers/cpufreq/exynos4210-cpufreq.c |  184 ----------------------------------
>  5 files changed, 1 insertion(+), 209 deletions(-)
>  delete mode 100644 drivers/cpufreq/exynos4210-cpufreq.c

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
