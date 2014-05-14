From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 14 May 2014 09:27:16 +0530
Subject: [PATCH v4 8/8] cpufreq: exynos: remove all exynos specific
 cpufreq driver support
In-Reply-To: <1400029876-5830-9-git-send-email-thomas.ab@samsung.com>
References: <1400029876-5830-1-git-send-email-thomas.ab@samsung.com>
 <1400029876-5830-9-git-send-email-thomas.ab@samsung.com>
Message-ID: <CAKohpo=vz8Tn=-Lqw5s5PicFmbin3aaOPKVFpfF0-Xnm7QVDfA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 May 2014 06:41, Thomas Abraham <ta.omasab@gmail.com> wrote:
> From: Thomas Abraham <thomas.ab@samsung.com>
>
> Exynos4210, Exynos4x12 and Exynos5250 based platforms have switched over
> to use cpufreq-cpu0 driver for cpufreq functionality. So the Exynos
> specific cpufreq drivers for these platforms can be removed.
>
> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> ---
>  drivers/cpufreq/Kconfig.arm          |   52 ---------
>  drivers/cpufreq/Makefile             |    4 -
>  drivers/cpufreq/exynos-cpufreq.c     |  209 ---------------------------------
>  drivers/cpufreq/exynos-cpufreq.h     |   91 ---------------
>  drivers/cpufreq/exynos4210-cpufreq.c |  157 -------------------------
>  drivers/cpufreq/exynos4x12-cpufreq.c |  211 ----------------------------------
>  drivers/cpufreq/exynos5250-cpufreq.c |  183 -----------------------------
>  7 files changed, 0 insertions(+), 907 deletions(-)

I *loved* this :)

Ack Ack Ack ...
