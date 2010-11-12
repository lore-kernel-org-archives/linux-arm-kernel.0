From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 12 Nov 2010 11:08:10 +0100
Subject: [PATCH] RFC: nomadik: expand timesource to 63 bits
In-Reply-To: <20101112095739.GH18358@pengutronix.de>
References: <1289466356-16697-1-git-send-email-linus.walleij@stericsson.com>
	<AANLkTi=ysONhPQBTbVNRgTOx5PGEM=STaUYY6RnUpfES@mail.gmail.com>
	<20101112095739.GH18358@pengutronix.de>
Message-ID: <4CDD120A.2050401@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Uwe Kleine-K?nig wrote:

> Instead of implementing sched_clock for each architecture seperatly,
> wouldn't it be nice to have a generic sched_clock that uses the
> architecture's clocksource?  I tried to implement that some time ago,
> but tglx shoot it down because of locking problems.

I was and still am a big fan of this approach, I am willing to help
testing it if you want to dust off this patch set...

Yours,
Linus Walleij
