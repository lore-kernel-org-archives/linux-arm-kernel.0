From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 7 Dec 2010 14:33:22 +0100
Subject: [PATCH 09/15] ARM: mxs: Add clock support
In-Reply-To: <AANLkTi=OTPd6wJ0hHO8jnO5NVC9f2ZpRDMeC7zWJwObG@mail.gmail.com>
References: <1290754154-9428-1-git-send-email-shawn.guo@freescale.com>
	<1290754154-9428-10-git-send-email-shawn.guo@freescale.com>
	<20101130163922.GT20449@pengutronix.de>
	<AANLkTi=OTPd6wJ0hHO8jnO5NVC9f2ZpRDMeC7zWJwObG@mail.gmail.com>
Message-ID: <20101207133322.GH21020@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Shawn,

> > Hmm, I would have used an approach that is quickly switchable to the
> > generic clock stuff posted a few times here. ?But probably already too
> > late. ?So it's up to you to decide when to switch (or if at all).
> >
> I suppose you are talking about the common struct clk patch from
> Jeremy Kerr.  Since mxs is closely tracking mxc, I would switch mxs
> only mxc is switched.
I want mxc switched sooner rather than later.

If you ask me, don't stop to be inovative because of tracking mxc which
supports many machines and so isn't that flexible as a new machine
support.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
