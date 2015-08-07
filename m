From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 7 Aug 2015 10:01:16 +0530
Subject: [PATCH v4 6/6] cpufreq: remove no longer needed
 CPU_FREQ_BOOST_SW config option
In-Reply-To: <1438868514-8814-7-git-send-email-b.zolnierkie@samsung.com>
References: <1438868514-8814-1-git-send-email-b.zolnierkie@samsung.com>
 <1438868514-8814-7-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <20150807043116.GI6325@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06-08-15, 15:41, Bartlomiej Zolnierkiewicz wrote:
> Remove no longer needed CPU_FREQ_BOOST_SW config option.
> 
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Thomas Abraham <thomas.ab@samsung.com>
> Cc: Javier Martinez Canillas <javier@osg.samsung.com>
> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  drivers/cpufreq/Kconfig      | 4 ----
>  drivers/cpufreq/freq_table.c | 3 ---
>  2 files changed, 7 deletions(-)

This must be applied only after fixing 1/6.

-- 
viresh
