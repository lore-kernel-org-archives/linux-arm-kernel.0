From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 14 Nov 2018 10:42:53 +0100
Subject: [PATCH] PM / AVS: SmartReflex: remove unused function
In-Reply-To: <10339961.29dihbgRqp@aspire.rjw.lan>
References: <20181006164059.16106-1-u.kleine-koenig@pengutronix.de>
 <10339961.29dihbgRqp@aspire.rjw.lan>
Message-ID: <20181114094253.v45kxd2efgwhuh42@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, Oct 16, 2018 at 11:09:11AM +0200, Rafael J. Wysocki wrote:
> On Saturday, October 6, 2018 6:40:59 PM CEST Uwe Kleine-K?nig wrote:
> > From: Uwe Kleine-K?nig <uwe@kleine-koenig.org>
> > 
> > omap_sr_register_pmic() was introduced in 2010 in commit
> > 
> > 	984aa6dbf4ca ("OMAP3: PM: Adding smartreflex driver support.")
> > 
> > . There was never any caller of this function in mainline resulting in a
> > warning
> > 
> > 	sr_init: No PMIC hook to init smartreflex
> > 
> > for each machine where this driver is enabled. So remove the unused
> > function and the pr_warn.
>
> Applied, thanks!

This patch didn't make it into next yet, is this expected?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
