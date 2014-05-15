From: dwalker@fifo99.com (dwalker at fifo99.com)
Date: Thu, 15 May 2014 21:57:26 +0000
Subject: [PATCH] arm: msm: remove board file for Nexus One (ie. mahimahi)
In-Reply-To: <1400177413.11786.11.camel@x220>
References: <1400101656.9826.4.camel@x220> <20140515174448.GA31159@fifo99.com>
 <1400177413.11786.11.camel@x220>
Message-ID: <20140515215726.GA1171@fifo99.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 15, 2014 at 08:10:13PM +0200, Paul Bolle wrote:
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

I don't mind if it gets removed, but I wouldn't ACK it's removal ..
 
> >  but I'm working on this one now..
> 
> That's good to hear.
> 
> >  So I don't want it deleted.
> 
> This is not something I get to decide. Nevertheless, given that this
> file shouldn't have been merged to begin with, I'd appreciate it if some
> deadline could be agreed upon.

I think I merged it actually, but there's no rules about what gets merged. How when what order, etc.
It's all free form.

> That being said, I'm not sure how having just this file in mainline
> helps your development efforts. It seems it did receive some updates
> for, well, treewide stuff. But it surely didn't get build coverage or
> runtime testing. So would you lose much if it only remains in your
> development tree?

It's effort to remove it.. Your asking for it to get removed, then re-added.. That sounds
like a fairly large amount of effort vs just leaving it in place.

Daniel
