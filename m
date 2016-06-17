From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 17 Jun 2016 11:46:50 +0200
Subject: [PATCH V3] clocksource/drivers/time-efm32: Convert init function
 to return error
In-Reply-To: <1466153059-16820-1-git-send-email-daniel.lezcano@linaro.org>
References: <20160617065250.GU26048@pengutronix.de>
 <1466153059-16820-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <20160617094650.GY26048@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 17, 2016 at 10:44:19AM +0200, Daniel Lezcano wrote:
> The init functions do not return any error and let the caller unaware of
> the state of the system.
> 
> Change that by converting the init functions to return an error conforming
> to the CLOCKSOURCE_OF_RET prototype.
> 
> Proper error handling (rollback, errno value) will be changed later case
> by case, thus this change just return back an error or success in the init
> function.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
