From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 02 Oct 2013 12:22:15 +0200
Subject: [PATCH] clocksource: dw_apb_timer_of: Mark a few more functions
 as __init
In-Reply-To: <1380616692-10253-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1380616692-10253-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <524BF3D7.3010600@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/01/2013 10:38 AM, Uwe Kleine-K?nig wrote:
> These are all only called by dw_apb_timer_init which is an __init
> function, too
>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---

Applied to my tree for 3.13

Thanks
   -- Daniel

-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
