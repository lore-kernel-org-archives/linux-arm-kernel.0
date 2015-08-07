From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 7 Aug 2015 17:09:50 +0530
Subject: [PATCH v4 0/6] cpufreq: use generic cpufreq drivers for
 Exynos4x12 platform
In-Reply-To: <2061119.GBaoSb4YSL@amdc1976>
References: <1438868514-8814-1-git-send-email-b.zolnierkie@samsung.com>
 <55C43971.5010504@samsung.com> <20150807051826.GJ6325@linux>
 <2061119.GBaoSb4YSL@amdc1976>
Message-ID: <20150807113950.GG6939@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07-08-15, 13:31, Bartlomiej Zolnierkiewicz wrote:
> Users don't need to enable the config option to get boost
> functionality working.  It is only needed to get scaling_boost_freqs
> sysfs attribute visible (which lists available boost freqs) when
> using cpufreq-dt driver.  Also the config option in question is not
> user visible.

By users I meant the people who will prepare the build images for the
release. They can just enable the config option :)

> The worst thing that happens if these 2 PM patches don't make it
> in time is that there will be no scaling_boost_freqs available
> when using cpufreq-dt driver.  Which is not very important from
> Exynos4x12 POV as it only supports single boost freq currently.

Right. So, now that your patch is Acked, send 1/6 and 6/6 separately
to pm-list and Rafael can get them merged himself..

I hope, your 6/6 patch will change a bit now ?

-- 
viresh
