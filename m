From: tglx@linutronix.de (Thomas Gleixner)
Date: Sun, 7 Jul 2013 17:30:31 +0200 (CEST)
Subject: [GIT PULL] clockevents/clocksource: Add Marvell Orion SoC
 timer
In-Reply-To: <20130707144645.GA11908@titan.lakedaemon.net>
References: <51B8D310.4050404@linaro.org> <51D9548B.9040907@gmail.com>
 <alpine.DEB.2.02.1307071508030.32106@ionos.tec.linutronix.de>
 <20130707144645.GA11908@titan.lakedaemon.net>
Message-ID: <alpine.DEB.2.02.1307071723220.32106@ionos.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 7 Jul 2013, Jason Cooper wrote:
> Sure, but to be clear, Daniel, please drop this patch from your tree.  I
> have no desire to create an out-of-tree dependency if we can avoid it.
> It has a habit of going horribly wrong [1].
> 
> I'll cherry-pick
> 
>   0c1dcfd clocksource: Add Marvell Orion SoC timer

Don't do that. Do a git fetch on that branch and then git merge
0c1dcfd. The patches before that Marvel commit are already in Linus
tree. That way it does not matter who sends first or not.

We don't force others to drop stuff and cherry picking is a nuisance
as well as you end up with two different commits doing the same thing.

Also for the next merge window: Can we please let everything under
drivers/clocksoure go through Daniels and my trees?

I'm starting to be grumpy about anyone thinking that this directory is
a public dump ground with no rules.

Thanks,

	tglx
