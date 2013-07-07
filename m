From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 7 Jul 2013 10:46:45 -0400
Subject: [GIT PULL] clockevents/clocksource: Add Marvell Orion SoC timer
In-Reply-To: <alpine.DEB.2.02.1307071508030.32106@ionos.tec.linutronix.de>
References: <51B8D310.4050404@linaro.org> <51D9548B.9040907@gmail.com>
 <alpine.DEB.2.02.1307071508030.32106@ionos.tec.linutronix.de>
Message-ID: <20130707144645.GA11908@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas,

On Sun, Jul 07, 2013 at 03:10:25PM +0200, Thomas Gleixner wrote:
> On Sun, 7 Jul 2013, Sebastian Hesselbarth wrote:
> > > ----------------------------------------------------------------
> > > Sebastian Hesselbarth (1):
> > >        clocksource: Add Marvell Orion SoC timer
> > 
> > with tip timers/core PR sent, I realized that the above did not make it
> > in. As we have a whole bunch of cleanup and DT conversion patches for
> 
> Opps. Fell through the cracks.

No problem.

> > v3.11-rc1 depending on it, would it be ok for you to let Jason Cooper
> > take it through his ARM sub-branch?
> 
> > If you are fine with it, I will resend the patch and note that Daniel
> > can drop it and Jason will take it.
> 
> Nah, Jason can just pull it from Daniels tree and be done with it.

Sure, but to be clear, Daniel, please drop this patch from your tree.  I
have no desire to create an out-of-tree dependency if we can avoid it.
It has a habit of going horribly wrong [1].

I'll cherry-pick

  0c1dcfd clocksource: Add Marvell Orion SoC timer

from dlezcano/timers/clockevents to get the Signed-off-by's Tested-by's,
etc.  If I could get an Acked-by from Daniel or Thomas on this, I'd
appreciate it.

Daniel, it looks like you only have cpuidle work going into linux-next.
If you do decide to include timers/clockevents, please drop the patch
before hand.

thx,

Jason.

[1] https://lkml.org/lkml/2013/2/28/725
