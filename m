From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 9 Jul 2015 15:52:54 +0530
Subject: [PATCH v3 0/4] cpufreq: use generic cpufreq drivers for
 Exynos5250 platform
In-Reply-To: <1435756238-845-1-git-send-email-b.zolnierkie@samsung.com>
References: <1435756238-845-1-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <20150709102254.GA5627@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01-07-15, 15:10, Bartlomiej Zolnierkiewicz wrote:
> This patch series removes the use of Exynos5250 specific support
> from cpufreq-exynos driver and enables the use of cpufreq-dt driver
> for this platform.
> 
> This patch series has been tested on Exynos5250 based Arndale board.
> 
> Changes since v1 (http://lkml.org/lkml/2015/4/13/611):
> - rebased on top of next-20150629 branch of linux-next kernel tree
> - dropped dependency on "[PATCH 0/6] cpufreq: use generic cpufreq
>   drivers for Exynos4x12 platform" patch series as it needs more
>   work (Viresh has requested porting of cpufreq-dt's boost mode
>   support over opp-v2 patches)
> 
> Changes since v2 (http://lkml.org/lkml/2015/6/29/361):
> - put the new cpu nodes in alphabetical order
> - updated Javier's and Mike's e-mail adresses
> - removed Cc: tag with stale Sachin's e-mail adress
> - added Reviewed-by: tag from Krzysztof to patches #3 and #4

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
