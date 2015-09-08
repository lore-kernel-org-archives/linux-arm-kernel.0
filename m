From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 8 Sep 2015 10:40:53 +0530
Subject: [PATCH v4 0/4] cpufreq-dt: add suspend frequency support
In-Reply-To: <55EE6892.3010304@samsung.com>
References: <1441640501-13613-1-git-send-email-b.zolnierkie@samsung.com>
 <20150908024659.GF26760@linux> <55EE5C79.2030604@samsung.com>
 <20150908042017.GJ26760@linux> <55EE6892.3010304@samsung.com>
Message-ID: <20150908051053.GA18554@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08-09-15, 13:48, Krzysztof Kozlowski wrote:
> Somehow my mind stuck on solving Exynos4x12 cpufreq issues.
> 
> Right, it should go through Rafael's, probably except DTS patch (4/4)
> because it depends on previous DTS changes. These changes are still in
> arm-soc, not in Linus' tree [0].

That's bad :(

Anyway, 4/4 is kind of independent to this series, in the sense that
it wouldn't harm even if it gets applied separately.

So, go ahead and apply 4/4 to Samsung's tree and rest of this can be
picked by Rafael.

-- 
viresh
