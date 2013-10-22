From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 22 Oct 2013 22:10:01 +0200
Subject: [PATCH v2] clocksource: Provide timekeeping for efm32 SoCs
In-Reply-To: <20131008145147.GP10079@pengutronix.de>
References: <1380830189-21553-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <5253ECC7.30700@linaro.org> <20131008145147.GP10079@pengutronix.de>
Message-ID: <20131022201001.GB27227@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 08, 2013 at 04:51:47PM +0200, Uwe Kleine-K?nig wrote:
> Hello Daniel,
> 
> On Tue, Oct 08, 2013 at 01:30:15PM +0200, Daniel Lezcano wrote:
> > On 10/03/2013 09:56 PM, Uwe Kleine-K?nig wrote:
> > >An efm32 features 4 16-bit timers with a 10-bit prescaler. This driver
> > >provides clocksource and clock event device using one timer instance
> > >each.
> > >
> > >Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > >---
> > 
> > Applied to my tree for 3.13
> Thanks
Where is your tree to be found? This commit isn't in

	git://git.linaro.org/people/dlezcano/linux.git clockevents/3.13

and also it's not included in next-20131021.

Best regards and thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
