From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 08 Oct 2013 13:30:15 +0200
Subject: [PATCH v2] clocksource: Provide timekeeping for efm32 SoCs
In-Reply-To: <1380830189-21553-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1380830189-21553-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <5253ECC7.30700@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/03/2013 09:56 PM, Uwe Kleine-K?nig wrote:
> An efm32 features 4 16-bit timers with a 10-bit prescaler. This driver
> provides clocksource and clock event device using one timer instance
> each.
>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---

Applied to my tree for 3.13

Thanks !
   -- Daniel

> Changes since (implicit) v1, sent with
> Message-id:1379324644-20934-1-git-send-email-u.kleine-koenig at pengutronix.de:
>
>   - drop unused #defines
>   - add __init to efm32_clocksource_init
>   - fix indention
>   - add a comment describing the reason for the construct in efm32_timer_init
>   - add device tree binding document
>     I created a new directory "timer" below the binding directory.

Why do you say you created a new directory ?

-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
