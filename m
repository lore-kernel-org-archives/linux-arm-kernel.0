From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 8 Sep 2015 08:16:59 +0530
Subject: [PATCH v4 0/4] cpufreq-dt: add suspend frequency support
In-Reply-To: <1441640501-13613-1-git-send-email-b.zolnierkie@samsung.com>
References: <1441640501-13613-1-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <20150908024659.GF26760@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07-09-15, 17:41, Bartlomiej Zolnierkiewicz wrote:
> Hi,
> 
> This patch series adds suspend frequency support (using opp-v2
> bindings and suspend-opp functionality) to cpufreq-dt driver and
> then adds suspend opp for Exynos4412 based boards.
> 
> This patch series fixes suspend/resume support on Exynos4412
> based Trats2 board and reboot hang on Exynos4412 based Odroid
> U3 board.
> 
> Changes since v3:
> - fixed dev_pm_opp_get_suspend_opp() locking
> - shortened variable name in dev_pm_opp_get_suspend_opp()
> - adjusted cpufreq_generic_suspend() to work with cpufreq-dt
> - removed no longer needed cpufreq_dt_suspend()
> - added Acked-by tag from Viresh to patch #4

Just a minor comment on 3/4 and after fixing that:

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
