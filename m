From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 11 Dec 2013 15:02:31 +0100
Subject: [GIT PULL RESEND2] clocksource/clockevents fixes for 3.13
In-Reply-To: <20131210194852.GB21814@gmail.com>
References: <52A767CB.3010501@linaro.org> <20131210194852.GB21814@gmail.com>
Message-ID: <52A87077.1030800@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/10/2013 08:48 PM, Ingo Molnar wrote:

[ ... ]

>>
>>   drivers/clocksource/Kconfig              |    1 +
>>   drivers/clocksource/clksrc-of.c          |    1 -
>>   drivers/clocksource/dw_apb_timer_of.c    |    7 ++++---
>>   drivers/clocksource/sun4i_timer.c        |    3 +++
>>   drivers/clocksource/time-armada-370-xp.c |   10 +++++-----
>>   5 files changed, 13 insertions(+), 9 deletions(-)
>
> Pulled into tip:timers/urgent, thanks a lot Daniel!

Thanks to you for helping me to be a better maintainer. All you comments 
and advices were very valuable.

   -- Daniel

-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
