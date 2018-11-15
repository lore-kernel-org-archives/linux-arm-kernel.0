From: rafael@kernel.org (Rafael J. Wysocki)
Date: Thu, 15 Nov 2018 03:28:50 +0100
Subject: [PATCH] PM / AVS: SmartReflex: remove unused function
In-Reply-To: <20181114094253.v45kxd2efgwhuh42@pengutronix.de>
References: <20181006164059.16106-1-u.kleine-koenig@pengutronix.de>
 <10339961.29dihbgRqp@aspire.rjw.lan>
 <20181114094253.v45kxd2efgwhuh42@pengutronix.de>
Message-ID: <CAJZ5v0g8Y+KTHmMfbzfhhRqs6MM9kq3p3J7R2tNvPZZs2iKhpQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 14, 2018 at 10:42 AM Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello,
>
> On Tue, Oct 16, 2018 at 11:09:11AM +0200, Rafael J. Wysocki wrote:
> > On Saturday, October 6, 2018 6:40:59 PM CEST Uwe Kleine-K?nig wrote:
> > > From: Uwe Kleine-K?nig <uwe@kleine-koenig.org>
> > >
> > > omap_sr_register_pmic() was introduced in 2010 in commit
> > >
> > >     984aa6dbf4ca ("OMAP3: PM: Adding smartreflex driver support.")
> > >
> > > . There was never any caller of this function in mainline resulting in a
> > > warning
> > >
> > >     sr_init: No PMIC hook to init smartreflex
> > >
> > > for each machine where this driver is enabled. So remove the unused
> > > function and the pr_warn.
> >
> > Applied, thanks!
>
> This patch didn't make it into next yet, is this expected?

It did some time ago, but then the branch it's on was neglected by
mistake.  Sorry about that.

I will merge it into my linux-next branch next week.

Thanks,
Rafael
