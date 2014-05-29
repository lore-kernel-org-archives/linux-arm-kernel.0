From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 29 May 2014 20:29:37 +0200
Subject: [PATCH] arm: msm: remove board file for Nexus One (ie. mahimahi)
In-Reply-To: <1400177413.11786.11.camel@x220>
References: <1400101656.9826.4.camel@x220> <20140515174448.GA31159@fifo99.com>
 <1400177413.11786.11.camel@x220>
Message-ID: <20140529182937.GA18230@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 2014-05-15 20:10:13, Paul Bolle wrote:
> Daniel,
> 
> On Thu, 2014-05-15 at 17:44 +0000, dwalker at fifo99.com wrote:
> > On Wed, May 14, 2014 at 11:07:36PM +0200, Paul Bolle wrote:
> > > Commit 1b802ff79f03 ("arm: msm: add board file for Nexus One (ie.
> > > mahimahi)") added just board-mahimahi.c. It did not add
> > > board-mahimahi.h, Makefile changes or Kconfig changes.
> > > 
> > > Four years have passed and this file is still dangling. Remove it.
> > > 
> > > Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> > > ---
> > > Untested. But what to test here?
> > > 
> > I don't mine if Sapphire gets removed,
> 
> Could you ACK that patch, please?
> 
> >  but I'm working on this one now..
> 
> That's good to hear.
> 
> >  So I don't want it deleted.
> 
> This is not something I get to decide. Nevertheless, given that this
> file shouldn't have been merged to begin with, I'd appreciate it if some
> deadline could be agreed upon.

Daniel is working on solving that. That should be enough. It is not as
the file is great problem to anybody.

If it is not fixed within year, you may want to retransmit your patch.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
