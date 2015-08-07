From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 7 Aug 2015 10:00:37 +0530
Subject: [PATCH v4 0/6] cpufreq: use generic cpufreq drivers for
 Exynos4x12 platform
In-Reply-To: <55C43085.8090506@samsung.com>
References: <1438868514-8814-1-git-send-email-b.zolnierkie@samsung.com>
 <015301d0d0a3$1396c900$3ac45b00$@kernel.org>
 <20150807035018.GF6325@linux> <20150807035156.GG6325@linux>
 <55C43085.8090506@samsung.com>
Message-ID: <20150807043037.GH6325@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07-08-15, 13:13, Krzysztof Kozlowski wrote:
> Still patches 1/6 and 6/6 need your acks. Is the patch 1/6 a
> prerequisite for others? It does not look like a prerequisite... but it
> was put at the beginning of the patchset.

Patch 1/6 is required to get boost working, that's all.. Not sure how
important is that. Anyway, that will work without 1/6 as well, all you
need to do is enable CONFIG_CPU_FREQ_BOOST_SW in you .config.

Anyway, it should go via pm tree and can be sent separately.

-- 
viresh
