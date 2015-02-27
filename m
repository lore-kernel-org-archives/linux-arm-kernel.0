From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 27 Feb 2015 08:46:01 +0100
Subject: [PATCH] clocksource: efm32: Use CLOCK_EVT_FEAT_PERIODIC for
 defining features
In-Reply-To: <3fac202ead48b50c0967c62eae92fe9786fd24a1.1425015704.git.viresh.kumar@linaro.org>
References: <3fac202ead48b50c0967c62eae92fe9786fd24a1.1425015704.git.viresh.kumar@linaro.org>
Message-ID: <20150227074601.GO7789@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Viresh,

On Fri, Feb 27, 2015 at 11:12:33AM +0530, Viresh Kumar wrote:
> We have used CLOCK_EVT_MODE_PERIODIC instead of CLOCK_EVT_FEAT_PERIODIC while
> defining features. Fix it.
> 
> Cc: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Makes sense, thanks for catching.

Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
