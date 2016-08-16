From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 16 Aug 2016 14:19:03 +0530
Subject: [PATCH 3/7] cpufreq: dt: Add exynos5433 compatible to use
 generic cpufreq driver
In-Reply-To: <1476eab3-48e2-2894-cc2a-e5a201b107cf@samsung.com>
References: <1471328843-26653-1-git-send-email-cw00.choi@samsung.com>
 <1471328843-26653-4-git-send-email-cw00.choi@samsung.com>
 <1476eab3-48e2-2894-cc2a-e5a201b107cf@samsung.com>
Message-ID: <20160816084903.GC21099@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16-08-16, 09:47, Krzysztof Kozlowski wrote:
> On 08/16/2016 08:27 AM, Chanwoo Choi wrote:
> > This patch adds the exynos5433 compatible string for supporting
> > the generic cpufreq driver on Exynos5433.
> > 
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > Cc: linux-pm at vger.kernel.org
> > Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> > ---
> >  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
> >  1 file changed, 1 insertion(+)
> 
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> 
> I guess this does not depend on the rest and can go through PM/cpufreq tree?
> 
> Viresh, Rafael,
> If you wish me to take it, let me know.

I will prefer it going through PM tree.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
