From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 24 Apr 2017 09:45:24 +0200
Subject: [PATCH 21/29] clocksource: Add missing line break to error
 messages
In-Reply-To: <1492374441-23336-21-git-send-email-daniel.lezcano@linaro.org>
References: <20170416202542.GV2078@mai>
 <1492374441-23336-1-git-send-email-daniel.lezcano@linaro.org>
 <1492374441-23336-21-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <20170424074524.2rdxtbi6n6czq6sf@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Sun, Apr 16, 2017 at 10:27:11PM +0200, Daniel Lezcano wrote:
>  drivers/clocksource/time-efm32.c          |  2 +-

For efm32:

	Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

(if it's not too late yet).

For efm32 (and I guess for others, too) this was introduced by the
"Convert init function to return error" series.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
