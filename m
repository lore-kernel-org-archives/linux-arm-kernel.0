From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 27 Jul 2015 17:31:37 +0530
Subject: [PATCH v2 3/7] cpufreq-dt: add turbo modes support
In-Reply-To: <2522396.6jWphaZxGp@amdc1976>
References: <1436456621-29839-1-git-send-email-b.zolnierkie@samsung.com>
 <15810554.2OjPyuYJBt@amdc1976> <20150727113340.GA10181@linux>
 <2522396.6jWphaZxGp@amdc1976>
Message-ID: <20150727120137.GD10181@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27-07-15, 13:58, Bartlomiej Zolnierkiewicz wrote:
> Thank you.  This is exactly the case here (I would like to get
> Exynos4x12 conversion to use cpufreq-dt + exynos-cpufreq removal
> in v4.3 if possible and adding new DT bindings will most likely
> slow down the process considerably).

Heh, I never asked you to add new DT bindings, I said we can solve it
with DT. We already have turbo properties in DT.

-- 
viresh
