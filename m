From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 29 Mar 2016 08:08:56 +0530
Subject: [PATCH 3/3] cpufreq: exynos: Use generic platdev driver
In-Reply-To: <56F9E9FC.7080007@samsung.com>
References: <cover.1458801338.git.viresh.kumar@linaro.org>
 <6cb29053bce7026dd9429326236a67c45e901c7b.1458801338.git.viresh.kumar@linaro.org>
 <56F9E9FC.7080007@samsung.com>
Message-ID: <20160329023856.GW32495@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29-03-16, 11:35, Krzysztof Kozlowski wrote:
> On 24.03.2016 15:40, Viresh Kumar wrote:
> > The cpufreq-dt-platdev driver supports creation of cpufreq-dt platform
> > device now, reuse that and remove similar code from platform code.
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  arch/arm/mach-exynos/exynos.c        | 25 -------------------------
> >  drivers/cpufreq/cpufreq-dt-platdev.c |  5 +++++
> >  2 files changed, 5 insertions(+), 25 deletions(-)
> 
> Hi,
> 
> I got only 3rd patch (and no cover letter). I don't know what is the
> background or what is your plan for this. I suppose you want to merge it
> through cupfreq tree? Anyway could you cc-me on everything (or at least
> cover letter)?

I bounced (mutt is great) all the other mails to you just now.

-- 
viresh
