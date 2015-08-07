From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 7 Aug 2015 17:26:27 +0530
Subject: [PATCH v4 0/6] cpufreq: use generic cpufreq drivers for
 Exynos4x12 platform
In-Reply-To: <2359635.Hxe4cb8zKm@amdc1976>
References: <1438868514-8814-1-git-send-email-b.zolnierkie@samsung.com>
 <2061119.GBaoSb4YSL@amdc1976> <20150807113950.GG6939@linux>
 <2359635.Hxe4cb8zKm@amdc1976>
Message-ID: <20150807115627.GH6939@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07-08-15, 13:47, Bartlomiej Zolnierkiewicz wrote:
> Hmm, wait.  Patch 6/6 depends on earlier changes.  I cannot remove
> the config option in question now as it is currently used by
> exynos-cpufreq specific boost support.  Patch 1/6 can be applied
> now but 6/6 needs to wait for patches 2-5 to be applied first.
> 
> Actually 6/6 is trivial and can be applied later in v4.3 cycle or
> even in v4.4 one.

Ack.

-- 
viresh
