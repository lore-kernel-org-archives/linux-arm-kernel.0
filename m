From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 02 Oct 2013 12:21:33 +0200
Subject: [PATCH] clocksource: put nodes passed to CLOCKSOURCE_OF_DECLARE
 callbacks centrally
In-Reply-To: <1380618053-11159-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1380618053-11159-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <524BF3AD.5000905@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/01/2013 11:00 AM, Uwe Kleine-K?nig wrote:
> Instead of letting each driver call of_node_put do it centrally in the
> loop that also calls the CLOCKSOURCE_OF_DECLARE callbacks. This is less
> prone to error and also moves getting and putting the references into the
> same function.
>
> Consequently all respective of_node_put calls in drivers are removed.
>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---

Applied in my tree for 3.13.

Thanks
   -- Daniel

-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
