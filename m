From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 1 May 2018 10:36:26 +0200
Subject: [PATCH] clocksource/drivers/timer-atmel-pit: properly handle
 error cases
In-Reply-To: <20180425101439.28908-1-alexandre.belloni@bootlin.com>
References: <20180425101439.28908-1-alexandre.belloni@bootlin.com>
Message-ID: <20180501083626.GE27619@mai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 25, 2018 at 12:14:39PM +0200, Alexandre Belloni wrote:
> smatch now reports a possible leak:
> 
> smatch warnings:
> drivers/clocksource/timer-atmel-pit.c:183 at91sam926x_pit_dt_init() warn: possible memory leak of 'data'
> 
> Ensure data is freed before exiting with an error.
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---

Applied for 4.17-rc

-- 

 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
