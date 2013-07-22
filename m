From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 22 Jul 2013 22:13:17 +0200
Subject: [PATCH v4 04/20] clocksource: samsung_pwm_timer: Do not use
 clocksource_mmio
In-Reply-To: <19090469.Cf6sbb33Ke@flatron>
References: <1374278673-25615-1-git-send-email-tomasz.figa@gmail.com>
 <1374278673-25615-6-git-send-email-tomasz.figa@gmail.com>
 <51ECAD60.1000109@linaro.org> <19090469.Cf6sbb33Ke@flatron>
Message-ID: <51ED925D.3060307@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/22/2013 09:47 AM, Tomasz Figa wrote:
> Hi Daniel,
> 
> On Monday 22 of July 2013 05:56:16 Daniel Lezcano wrote:
>> On 07/20/2013 02:04 AM, Tomasz Figa wrote:
>>> In case of Samsung PWM timer, clocksource MMIO can not be used,
>>> because
>>> custom suspend/resume callbacks are required.
>>>
>>> Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
>>> ---
>>
>> Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> Thanks for review.
> 
>> Please in the future Cc me and Thomas Gleixner (clocksource/clockevent
>> maintainers).
> 
> Oh, right, sorry. This series originally was not touching the clocksource 
> driver and I just kept original recipient list.
> 
> Btw. Have you updated MAINTAINERS file? In latest linux-next I can still 
> see only John Stultz and Thomas Gleixner as maintainers of 
> drivers/clocksource.

Yes, right last week :)

https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git/commit/?h=timers/core&id=9222d247bcbaacc40fe15549158f9d67523c1ace

Thanks
  -- Daniel

-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
