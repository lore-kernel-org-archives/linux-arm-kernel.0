From: lost.distance@yahoo.com (Paul Parsons)
Date: Tue, 15 May 2012 13:22:44 +0100 (BST)
Subject: [GIT PULL][for 3.5] pull request of board-specific branch in
 arch-pxa git tree
In-Reply-To: <201205151140.07655.arnd@arndb.de>
Message-ID: <1337084564.4250.YahooMailClassic@web29010.mail.ird.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnd,

--- On Tue, 15/5/12, Arnd Bergmann <arnd@arndb.de> wrote:
> > > Did you miss a dependency? Should I revert that
> patch for
> > > now?
> > 
> > hx4700.c expects to find the clock_rate field in the
> > asic3_platform_data structure.
> > 
> > The clock_rate field is due to be added in V3.5:
> > 
> > http://lkml.indiana.edu/hypermail/linux/kernel/1204.2/00339.html
> > 
> 
> This is not good, you should not split patches in a way that
> breaks
> the individual pieces. It would have been better to just
> take the entire
> patch through either arm-soc or the mfd tree.
> 
> Any suggestions for a way out of this mess? I'm inclined to
> just
> revert the patch I have and let Samuel pick it up to submit
> it along
> with the other half.

I apologise if it's causing problems; I was trying to avoid
crossing maintainer boundaries.

Revert it and I'll resubmit it unchanged for V3.6.

Regards,
Paul
