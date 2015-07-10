From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 10 Jul 2015 17:57:02 +0900
Subject: [PATCH v2 7/7] cpufreq: exynos: remove Exynos4x12 specific cpufreq
 driver support
In-Reply-To: <1436456621-29839-8-git-send-email-b.zolnierkie@samsung.com>
References: <1436456621-29839-1-git-send-email-b.zolnierkie@samsung.com>
 <1436456621-29839-8-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <559F88DE.1020202@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10.07.2015 00:43, Bartlomiej Zolnierkiewicz wrote:
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
> Cc: Javier Martinez Canillas <javier@dowhile0.org>
> Cc: Thomas Abraham <thomas.ab@samsung.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  drivers/cpufreq/Kconfig.arm          |  23 ----
>  drivers/cpufreq/Makefile             |   2 -
>  drivers/cpufreq/exynos-cpufreq.c     | 231 ----------------------------------
>  drivers/cpufreq/exynos-cpufreq.h     |  72 -----------
>  drivers/cpufreq/exynos4x12-cpufreq.c | 236 -----------------------------------
>  5 files changed, 564 deletions(-)
>  delete mode 100644 drivers/cpufreq/exynos-cpufreq.c
>  delete mode 100644 drivers/cpufreq/exynos-cpufreq.h
>  delete mode 100644 drivers/cpufreq/exynos4x12-cpufreq.c

Code removal is awesome!
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
