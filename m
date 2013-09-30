From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 30 Sep 2013 16:29:12 +0200
Subject: [GIT PULL v2] drivers/clocksource: sched_clock_register()
 conversion for 3.13 (via tip/timers/core)
In-Reply-To: <52448A46.9020207@linaro.org>
References: <52448A46.9020207@linaro.org>
Message-ID: <52498AB8.7090209@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/26/2013 09:25 PM, John Stultz wrote:
> Hey Daniel,
>      Here's the sched_clock_register conversion that Stephen did earlier
> this summer, as part of extending the generic sched_clock code to
> support 64bit counters. Unfortunately the prereqs for this series missed
> getting into tip/timers/core for 3.12, so I never sent out this pull
> request. But now that the prereqs are in tip/timers/core for 3.13, I've
> merge it up and I wanted to go ahead and send this out.
>
> This v2 pull request removes the setup_sched_clock deprecation, as that
> causes lots of warnings since there's still users in the arch/arm tree.
>
> Let me know if you have any issues or concerns.

Thanks John,

pulled in my tree as 3.13 material.

   -- Daniel


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
