From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 9 Sep 2016 14:29:52 +0200
Subject: [PATCH v4 0/3] clocksource: timer-atmel-pit: driver cleanups
In-Reply-To: <20160909111350.27534-1-alexandre.belloni@free-electrons.com>
References: <20160909111350.27534-1-alexandre.belloni@free-electrons.com>
Message-ID: <c9de6c9e-e7a7-33bb-7fda-9802f616d594@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/09/2016 13:13, Alexandre Belloni wrote:
> Hi Daniel,
> 
> This is just the cleanup part of the previous seris as the fix has been applied.
> 
> It is rebased on top of v4.8-rc5 and should apply cleanly.
> 
> Alexandre Belloni (3):
>   clocksource: timer-atmel-pit: drop at91sam926x_pit_common_init
>   clocksource: timer-atmel-pit: remove uselesss WARN_ON_ONCE
>   clocksource: timer-atmel-pit: simplify IRQ handler
> 
>  drivers/clocksource/timer-atmel-pit.c | 96 ++++++++++++++---------------------
>  1 file changed, 37 insertions(+), 59 deletions(-)

Ok, I have applied the series.

Thanks.

  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
