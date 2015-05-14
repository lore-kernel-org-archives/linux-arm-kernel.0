From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 14 May 2015 10:37:19 +0530
Subject: [PATCH 5/6] ARM: Exynos: switch to using generic cpufreq driver
 for Exynos4210
In-Reply-To: <1428079429-4252-6-git-send-email-b.zolnierkie@samsung.com>
References: <'@samsung.com>
 <1428079429-4252-1-git-send-email-b.zolnierkie@samsung.com>
 <1428079429-4252-6-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <20150514050719.GA9887@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03-04-15, 18:43, Bartlomiej Zolnierkiewicz wrote:
> From: Thomas Abraham <thomas.ab@samsung.com>
> 
> The new CPU clock type allows the use of generic CPUfreq driver.
> Switch Exynos4210 to using generic cpufreq driver.
> 
> Changes by Bartlomiej:
> - removed non-Exynos4210 support for now
> 
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  arch/arm/mach-exynos/exynos.c |   21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
