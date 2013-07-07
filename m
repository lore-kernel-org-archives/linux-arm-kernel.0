From: tglx@linutronix.de (Thomas Gleixner)
Date: Sun, 7 Jul 2013 15:10:25 +0200 (CEST)
Subject: [GIT PULL] clockevents/clocksource: Add Marvell Orion SoC
 timer
In-Reply-To: <51D9548B.9040907@gmail.com>
References: <51B8D310.4050404@linaro.org> <51D9548B.9040907@gmail.com>
Message-ID: <alpine.DEB.2.02.1307071508030.32106@ionos.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 7 Jul 2013, Sebastian Hesselbarth wrote:
> > ----------------------------------------------------------------
> > Sebastian Hesselbarth (1):
> >        clocksource: Add Marvell Orion SoC timer
> 
> with tip timers/core PR sent, I realized that the above did not make it
> in. As we have a whole bunch of cleanup and DT conversion patches for

Opps. Fell through the cracks.

> v3.11-rc1 depending on it, would it be ok for you to let Jason Cooper
> take it through his ARM sub-branch?

> If you are fine with it, I will resend the patch and note that Daniel
> can drop it and Jason will take it.

Nah, Jason can just pull it from Daniels tree and be done with it.

Thanks,

	tglx
