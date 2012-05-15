From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 15 May 2012 12:28:54 +0000
Subject: [GIT PULL][for 3.5] pull request of board-specific branch in
 arch-pxa git tree
In-Reply-To: <1337084564.4250.YahooMailClassic@web29010.mail.ird.yahoo.com>
References: <1337084564.4250.YahooMailClassic@web29010.mail.ird.yahoo.com>
Message-ID: <201205151228.54881.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 15 May 2012, Paul Parsons wrote:
> > This is not good, you should not split patches in a way that
> > breaks
> > the individual pieces. It would have been better to just
> > take the entire
> > patch through either arm-soc or the mfd tree.
> > 
> > Any suggestions for a way out of this mess? I'm inclined to
> > just
> > revert the patch I have and let Samuel pick it up to submit
> > it along
> > with the other half.
> 
> I apologise if it's causing problems; I was trying to avoid
> crossing maintainer boundaries.
> 
> Revert it and I'll resubmit it unchanged for V3.6.

We can still get it into 3.5, that's not the problem, let's
just try to keep the kernel bisectible in the process.

	Arnd
