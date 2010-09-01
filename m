From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 1 Sep 2010 12:02:03 +0200
Subject: [PATCH 02/19] ARM: sa1111: move __sa1111_probe() to .devinit.text
In-Reply-To: <1281017333-5563-2-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20100805140813.GA13859@pengutronix.de>
	<1281017333-5563-2-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20100901100203.GB11107@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

On Thu, Aug 05, 2010 at 04:08:36PM +0200, Uwe Kleine-K?nig wrote:
> __sa1111_probe is only called by sa1111_probe that lives in .devinit.text.
> So it's save to move the former to .devinit.text, too.
> 
> Acked-by: Kristoffer Ericson <kristoffer.ericson@gmail.com>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Should/can I send the fixes in this series that are not yet in mainline to
your patch system?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
