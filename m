From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 6 May 2011 10:25:24 +0200
Subject: [PATCH v3] leds: provide helper to register "leds-gpio" devices
In-Reply-To: <20110426150815.GY31131@pengutronix.de>
References: <1302097097.22904.41.camel@rex>
	<1302554157-24145-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20110426150815.GY31131@pengutronix.de>
Message-ID: <20110506082524.GR11574@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Richard,

On Tue, Apr 26, 2011 at 05:08:15PM +0200, Uwe Kleine-K?nig wrote:
> On Mon, Apr 11, 2011 at 10:35:57PM +0200, Uwe Kleine-K?nig wrote:
> > This function makes a deep copy of the platform data to allow it to live
> > in init memory.
> > The definition cannot go into leds-gpio.c because it needs to be builtin
> > to be usable by platforms.
> > 
> > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> any comment by you?
ping

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
