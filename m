From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 16 Dec 2015 07:44:46 +0530
Subject: [PATCH v6 0/7] cpufreq: add generic cpufreq driver support for
 Exynos542x/5800 platforms
In-Reply-To: <1450200801-24539-1-git-send-email-b.zolnierkie@samsung.com>
References: <1450200801-24539-1-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <20151216021446.GC3111@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15-12-15, 18:33, Bartlomiej Zolnierkiewicz wrote:
> Hi,
> 
> This patch series adds generic cpufreq-dt driver support for
> Exynos542x/5800 (using the new CPU clock type which allows it).
> 
> It has been tested on Exynos5422 based ODROID-XU3 Lite board.
> 
> Depends on:
> - next-20151211 branch of linux-next kernel tree
> - "[PATCH] ARM: dts: Make CPU configuration more readable for
>   exynos542x/5800" patch (https://lkml.org/lkml/2015/12/11/107)
> 
> Changes since v5:
> - rebased over next-20151211 branch (something is broken in
>   newer branches, namely next-2015121[45])
> - rebased on top of "ARM: dts: Make CPU configuration more
>   readable for exynos542x/5800" patch
> - renamed cpu0_opp_table to cluster_a15_opp_table and
>   cpu1_opp_table to cluster_a7_opp_table
> - added Reviewed-by from Krzysztof

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
