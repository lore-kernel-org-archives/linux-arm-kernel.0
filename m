From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 8 Oct 2013 16:51:47 +0200
Subject: [PATCH v2] clocksource: Provide timekeeping for efm32 SoCs
In-Reply-To: <5253ECC7.30700@linaro.org>
References: <1380830189-21553-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <5253ECC7.30700@linaro.org>
Message-ID: <20131008145147.GP10079@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Daniel,

On Tue, Oct 08, 2013 at 01:30:15PM +0200, Daniel Lezcano wrote:
> On 10/03/2013 09:56 PM, Uwe Kleine-K?nig wrote:
> >An efm32 features 4 16-bit timers with a 10-bit prescaler. This driver
> >provides clocksource and clock event device using one timer instance
> >each.
> >
> >Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> >---
> 
> Applied to my tree for 3.13
Thanks
> >  - add device tree binding document
> >    I created a new directory "timer" below the binding directory.
> 
> Why do you say you created a new directory ?
That's because there was no directory for clockevent devices and clock
sources before. So there is a new task to check where (if at all) the
other drivers document their binding.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
