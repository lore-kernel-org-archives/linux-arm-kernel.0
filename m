From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 24 Apr 2011 09:27:31 +0200
Subject: [patch 00/16] arm: Replace arm sched_clock by clocksource based
	sched_clock
In-Reply-To: <20110423205036.795894921@linutronix.de>
References: <20110423205036.795894921@linutronix.de>
Message-ID: <BANLkTi=5Uz_TNKOiJKDn7Mh30fxv3aY67Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/4/23 Thomas Gleixner <tglx@linutronix.de>:

> Most of ARM sched_clocks is using the timekeeping clocksource as the
> sched_clock. Only versatile uses a different clock for it, but there
> is no real reason why it can't use the clocksource as well.

Excellent patch set!

> Another 650 lines gone :)

Any reason why we can't simply move *all* of these to
drivers/clocksource/* and proceed with consolidation there?

It must be a pain having to grep through the tree to find all of
these (even though I bet you know them all by heart now).

Yours,
Linus Walleij
