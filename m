From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 27 Jul 2015 16:05:21 +0530
Subject: [PATCH v2 2/7] cpufreq: opp: fix handling of turbo modes
In-Reply-To: <1595601.YD6UTxy5Qg@amdc1976>
References: <1436456621-29839-1-git-send-email-b.zolnierkie@samsung.com>
 <1436456621-29839-3-git-send-email-b.zolnierkie@samsung.com>
 <20150727083531.GC31611@linux> <1595601.YD6UTxy5Qg@amdc1976>
Message-ID: <20150727103521.GA4103@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27-07-15, 12:24, Bartlomiej Zolnierkiewicz wrote:
> Have you read my explanation of the issue?
> 
> With your OPP-v2 patches cpufreq-dt picks turbo frequencies and uses
> them as normal ones.
> 
> (More at: http://www.spinics.net/lists/arm-kernel/msg430397.html)

Yes I did. I understand that the turbo frequencies are not considered
as such by OPP/cpufreq core and it requires your changes to get it
working.

But its not an issue or bug we are fixing, the problem is that the
code for opp-v2 isn't complete yet and your patches is putting things
in place. So, we are still doing the bring up here and not fixing a
bug really.

-- 
viresh
