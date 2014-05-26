From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 26 May 2014 11:48:24 +0530
Subject: [PATCH v5 7/7] cpufreq: exynos: remove all exynos specific
 cpufreq driver support
In-Reply-To: <1400855260-6807-8-git-send-email-thomas.ab@samsung.com>
References: <1400855260-6807-1-git-send-email-thomas.ab@samsung.com>
 <1400855260-6807-8-git-send-email-thomas.ab@samsung.com>
Message-ID: <CAKohpokP8Kwygi-DbUmEc8EkGYYkO8+NRUN4VDyJ3SXWXViN2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 May 2014 19:57, Thomas Abraham <thomas.ab@samsung.com> wrote:
> From: Thomas Abraham <thomas.ab@samsung.com>
>
> Exynos4210, Exynos4x12 and Exynos5250 based platforms have switched over
> to use cpufreq-cpu0 driver for cpufreq functionality. So the Exynos
> specific cpufreq drivers for these platforms can be removed.
>
> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> ---
>  drivers/cpufreq/Kconfig.arm          |   52 --------
>  drivers/cpufreq/Makefile             |    4 -
>  drivers/cpufreq/exynos-cpufreq.c     |  218 ----------------------------------
>  drivers/cpufreq/exynos-cpufreq.h     |   99 ---------------
>  drivers/cpufreq/exynos4210-cpufreq.c |  157 ------------------------
>  drivers/cpufreq/exynos4x12-cpufreq.c |  208 --------------------------------
>  drivers/cpufreq/exynos5250-cpufreq.c |  183 ----------------------------
>  7 files changed, 921 deletions(-)
>  delete mode 100644 drivers/cpufreq/exynos-cpufreq.c
>  delete mode 100644 drivers/cpufreq/exynos-cpufreq.h
>  delete mode 100644 drivers/cpufreq/exynos4210-cpufreq.c
>  delete mode 100644 drivers/cpufreq/exynos4x12-cpufreq.c
>  delete mode 100644 drivers/cpufreq/exynos5250-cpufreq.c

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
