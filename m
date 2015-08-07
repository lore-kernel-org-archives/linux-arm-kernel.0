From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 7 Aug 2015 16:11:56 +0530
Subject: [PATCH v4 1/6] cpufreq: make scaling_boost_freqs sysfs attr
 available when boost is enabled
In-Reply-To: <5184469.cOpIkgzX4h@amdc1976>
References: <1438868514-8814-1-git-send-email-b.zolnierkie@samsung.com>
 <1438868514-8814-2-git-send-email-b.zolnierkie@samsung.com>
 <20150807034128.GE6325@linux> <5184469.cOpIkgzX4h@amdc1976>
Message-ID: <20150807104156.GE6939@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07-08-15, 12:34, Bartlomiej Zolnierkiewicz wrote:
> > I would suggest you sending such patches as reply to the earlier
> > threads only, instead of a new chain. This will save your time.
> 
> Please explain it more.  This patch needs to be first for cpufreq-dt
> switch to be complete.  scaling_boost_freqs is available currently
> for exynos-cpufreq users when boost is enabled and ideally we would
> like it to be available immediately after the switch to cpufreq-dt.

I wasn't talking about the ordering of the patches here, but when to
send patches.

So, you now sent these patches again, but what you could have done
is: only send the first patch in reply to the earlier thread. And ask
if it looks fine. If yes, resend the whole series properly or keep
fixing there only..

That makes things really fast. You don't have to resend the series and
people wouldn't stay away from it. I stayed away from this series to
find enough available time to see your 6 patches. Had it been just a
reply, I would have replied immediately like now.

Look at how updated versions in the same mail chain in case of OPP
series..

-- 
viresh
