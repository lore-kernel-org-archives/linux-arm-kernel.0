From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 12 Nov 2010 11:31:18 +0100 (CET)
Subject: [PATCH] RFC: nomadik: expand timesource to 63 bits
In-Reply-To: <4CDD120A.2050401@stericsson.com>
References: <1289466356-16697-1-git-send-email-linus.walleij@stericsson.com>
	<AANLkTi=ysONhPQBTbVNRgTOx5PGEM=STaUYY6RnUpfES@mail.gmail.com>
	<20101112095739.GH18358@pengutronix.de>
	<4CDD120A.2050401@stericsson.com>
Message-ID: <alpine.LFD.2.00.1011121130350.2900@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 12 Nov 2010, Linus Walleij wrote:

> Uwe Kleine-K?nig wrote:
> 
> > Instead of implementing sched_clock for each architecture seperatly,
> > wouldn't it be nice to have a generic sched_clock that uses the
> > architecture's clocksource?  I tried to implement that some time ago,
> > but tglx shoot it down because of locking problems.
> 
> I was and still am a big fan of this approach, I am willing to help
> testing it if you want to dust off this patch set...

sched_clock is not necessarily the same as the current clocksource.

Thanks,

	tglx
