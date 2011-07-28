From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 28 Jul 2011 17:58:27 +0200
Subject: [PULL] at91 init factorize
In-Reply-To: <20110727233452.GN10037@game.jcrosoft.org>
References: <20110727121156.GK10037@game.jcrosoft.org>
	<201107271647.44015.arnd@arndb.de>
	<20110727233452.GN10037@game.jcrosoft.org>
Message-ID: <201107281758.27738.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 28 July 2011, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > The patches look good, but come at an inconvenient time. We're still
> > in the merge window, so I don't want to add stuff to linux-next yet
> > that is destined for 3.2, and I have already sent out all the arm-soc
> > patches for the 3.1 merge window, so I don't really want to send another
> > round of patches at the last minute.
> this are waiting ofr 2 release already
> 
> and was inthe next last release for more than 1 month
> 
> can we have them merge this time

What I don't understand at all is why you are waiting instead of sending
a pull request for all that time then. I've repeatedly given announcements
about the state of the arm-soc tree and asked people to send patches
they want in 3.1, and you actually sent bug fixes that way earlier.

You've had more than enough time before the merge window, and would even
have made an exception if you had sent your stuff a few hours earlier,
before I sent everything to Linus.
Also, the branch you sent me was created on the same day, meaning that
it can't possibly have had a lot of testing (though it looks harmless
enough). When you send a pull request, the patches should always be
based on an -rc or main release to simplify the merge history, and
it's better not to rebase to the latest one if you already have the
patches.

I've put it into the for-next branch now, and rebased to the previous
tag from the upstream kernel (v3.0). I've also fixed up a trivial bug
I noticed the last time I looked at the patches (the extraneous 
at91_readl function).

	Arnd
