From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 9 Jan 2017 21:06:29 +0100
Subject: [PATCH 0/3] watchdog: imx2: handle WMCR only being available on
 i.MX35 and later
In-Reply-To: <20170109171959.GA7274@roeck-us.net>
References: <20170109095039.11979-1-u.kleine-koenig@pengutronix.de>
 <20170109171959.GA7274@roeck-us.net>
Message-ID: <20170109200629.jwknq6lauknlzsqi@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 09, 2017 at 09:19:59AM -0800, Guenter Roeck wrote:
> On Mon, Jan 09, 2017 at 10:50:36AM +0100, Uwe Kleine-K?nig wrote:
> > this is my approach to fix the issue reported by Vladimir Zapolskiy.
> > 
> So ...
> 
> Unfortunately, I don't see any convergence on this issue. My take is that,
> given the lack of convergence, it can't be that severe since no one feels
> that it is important enough to get it fixed one way or the other to budge
> from your positions.

I didn't get any critic for my patch set yet apart from being a second
one to address the same problem. So until proven differently I assume
that mine is fine.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
