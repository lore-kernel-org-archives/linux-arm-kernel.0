From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 13 Nov 2013 14:53:05 +0100 (CET)
Subject: [GIT PULL] clockevents/clocksource: 3.12 fixes
In-Reply-To: <20131113103632.GV14892@pengutronix.de>
References: <528234B9.7080402@linaro.org>
 <20131112183553.GQ14892@pengutronix.de>
 <alpine.DEB.2.02.1311122316270.30673@ionos.tec.linutronix.de>
 <20131113103632.GV14892@pengutronix.de>
Message-ID: <alpine.DEB.2.02.1311131358310.30673@ionos.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 13 Nov 2013, Uwe Kleine-K?nig wrote:
> On Tue, Nov 12, 2013 at 11:57:46PM +0100, Thomas Gleixner wrote:
> > The whole misery starts that you decided to play maintainer and grab
> > some patches from the mailinglist and then offering them via a pull
> > request to me and others. Finally you tricked Daniel to take them,
> >From my POV this isn't "playing maintainer". You stopped reacting on the
> issue and I thought I make it easier for you (and others) to handle the
> patches in case you didn't take because of being busy with other stuff.

Yes, I vanished for a few weeks because I was busy otherwise. Where is
the problem? The world was still turning and the fix was not a highly
critical issue.

And your "make it easier" thing is utter bullshit. It takes me less
time to apply a single patch from mail than pulling a tree and
verifying the commit.

Aside of that, core code goes always directly through me and not via
Daniel.

Dammit, there are established workflows and there is no reason, except
for a highly critical bug fix to circumvent them. And if such a
situation happens, then the correct thing is to resend the patch to
Andrew and Linus and explaining, why its critical and can't wait for
the lazy maintainer to reappear.

Me and others have observed your busybody behaviour often enough. It
does not really earn you trust and respect.

Just for the record: I'm not pulling anything from you and I'm not
going to pull a tree from my submaintainers which contains a merge
from you.

Thanks,

	tglx
