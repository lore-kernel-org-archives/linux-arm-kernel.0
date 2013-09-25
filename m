From: john.stultz@linaro.org (John Stultz)
Date: Tue, 24 Sep 2013 17:54:35 -0700
Subject: [GIT PULL] drivers/clocksource: sched_clock_register() conversion
 for 3.13 (via tip/timers/core)
In-Reply-To: <52422732.5000501@linaro.org>
References: <52422732.5000501@linaro.org>
Message-ID: <5242344B.8020002@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/24/2013 04:58 PM, John Stultz wrote:
> Hey Daniel,
>     Here's the sched_clock_register conversion that Stephen did earlier
> this summer, as part of extending the generic sched_clock code to
> support 64bit counters. Unfortunately the prereqs for this series missed
> getting into tip/timers/core for 3.12, so I never sent out this pull
> request. But now that the prereqs are in tip/timers/core for 3.13, I've
> merge it up and I wanted to go ahead and send this out.
>
> Let me know if you have any issues or concerns.
Hey Daniel,
    Maybe hold off on this one. The kbuild test robot is has some
complaints aobut the deprecation of setup_sched_clock() while there are
still users in arch/arm.

I'll likely rework a new branch for you to pull that will be all but the
"Deprecate setup_sched_clock()" patch.


thanks
-john
