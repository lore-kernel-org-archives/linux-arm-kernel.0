From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 24 Sep 2013 23:16:41 +0200
Subject: [PATCH v2] clockevents: Sanitize ticks to nsec conversion
In-Reply-To: <1380052223-24139-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <alpine.DEB.2.02.1309191629040.4089@ionos.tec.linutronix.de>
 <1380052223-24139-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20130924211641.GF16106@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Thomas,

just found another little issue ...

On Tue, Sep 24, 2013 at 09:50:23PM +0200, Uwe Kleine-K?nig wrote:
> +/**
> + * clockevents_delta2ns - Convert a latch value (device ticks) to nanoseconds
> + * @latch:	value to convert
> + * @evt:	pointer to clock event device descriptor
> + *
> + * Math helper, returns latch value converted to nanoseconds (bound checked)
> + */
> +u64 clockevent_delta2ns(unsigned long latch, struct clock_event_device *evt)
... the kernel-doc comment has an 's' too much in the function name.

I'm not sending a v3 for just that. Can you fix that up when/if
applying?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
