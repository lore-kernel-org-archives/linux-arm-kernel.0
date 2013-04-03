From: khilman@linaro.org (Kevin Hilman)
Date: Wed, 03 Apr 2013 14:43:41 -0700
Subject: [PATCH 8/9] ARM: omap3: cpuidle: enable time keeping
In-Reply-To: <515C95BF.6030103@linaro.org> (Daniel Lezcano's message of "Wed,
 03 Apr 2013 22:49:03 +0200")
References: <1364991322-20585-1-git-send-email-daniel.lezcano@linaro.org>
 <1364991322-20585-8-git-send-email-daniel.lezcano@linaro.org>
 <87zjxfzetw.fsf@linaro.org> <515C95BF.6030103@linaro.org>
Message-ID: <87txnnp9wy.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel Lezcano <daniel.lezcano@linaro.org> writes:

> On 04/03/2013 07:47 PM, Kevin Hilman wrote:
>> Daniel Lezcano <daniel.lezcano@linaro.org> writes:
>> 
>>> The TIME_VALID flag is specified for the different states but
>>> the time residency computation is not done, no tk flag, no time
>>> computation in the idle function.
>>>
>>> Set the en_core_tk_irqen flag to activate it.
>>>
>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> 
>> Acked-by: Kevin Hilman <khilman@linaro.org>
>> 
>> Also, is this a regression fix that also needs to hit v3.9?
>
> Yes, I think so.

OK.

I've got a handful of other OMAP CPUidle fixes queued for v3.10[1] so
I'll add this one to the queue and Cc: stable.

Thanks,

Kevin

[1]
git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_3.10/cleanup/cpuidle
