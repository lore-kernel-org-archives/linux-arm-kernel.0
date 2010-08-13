From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 13 Aug 2010 11:08:49 +0200
Subject: [PATCH v3] mx35: Fix boot ROM hang in internal boot mode
In-Reply-To: <20100812131053.GD8670@local>
References: <20100812131053.GD8670@local>
Message-ID: <20100813090849.GB27637@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 12, 2010 at 03:10:53PM +0200, Hans J. Koch wrote:
> If a watchdog reset occurs after booting in internal boot mode, the i.MX35
> won't boot anymore. The boot ROM code seems to assume that some clocks are
> turned on (they are after a power-on reset). This patch turns on the
> necessary clocks.
> 
> Signed-off-by: Hans J. Koch <hjk@linutronix.de>
Even if it should be a bootloader issue and not a ROM problem this fix
is sensible.

Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
