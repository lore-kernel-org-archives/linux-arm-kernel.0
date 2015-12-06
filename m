From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Sun, 6 Dec 2015 07:56:04 +0530
Subject: [PATCH v3 0/10] cpufreq: add generic cpufreq driver support for
 Exynos542x/5800 platforms
In-Reply-To: <3776700.7KBsWa2Q4V@amdc1976>
References: <1449250235-9613-1-git-send-email-b.zolnierkie@samsung.com>
 <20151205035444.GR3430@ubuntu> <3776700.7KBsWa2Q4V@amdc1976>
Message-ID: <20151206022604.GW3430@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05-12-15, 08:49, Bartlomiej Zolnierkiewicz wrote:
> Why I appreciate Ben's work this not exactly the same thing as
> the above patchset lacks critical CLK_RECALC_NEW_RATES bugfix and
> few other minor fixes.

I am not saying that these are exactly same, code wise, but you are
both targeting to solve the same problem.

> > And the comments given there applies to you as well.
> 
> Yes, sure.  That's why I wrote that this is work-in-progress
> and put the TODO in the cover letter.

As I mentioned there, you need to migrate to cpufreq-dt instead of
arm-big-little now.

-- 
viresh
