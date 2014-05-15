From: pebolle@tiscali.nl (Paul Bolle)
Date: Thu, 15 May 2014 20:10:13 +0200
Subject: [PATCH] arm: msm: remove board file for Nexus One (ie. mahimahi)
In-Reply-To: <20140515174448.GA31159@fifo99.com>
References: <1400101656.9826.4.camel@x220> <20140515174448.GA31159@fifo99.com>
Message-ID: <1400177413.11786.11.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel,

On Thu, 2014-05-15 at 17:44 +0000, dwalker at fifo99.com wrote:
> On Wed, May 14, 2014 at 11:07:36PM +0200, Paul Bolle wrote:
> > Commit 1b802ff79f03 ("arm: msm: add board file for Nexus One (ie.
> > mahimahi)") added just board-mahimahi.c. It did not add
> > board-mahimahi.h, Makefile changes or Kconfig changes.
> > 
> > Four years have passed and this file is still dangling. Remove it.
> > 
> > Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> > ---
> > Untested. But what to test here?
> > 
> I don't mine if Sapphire gets removed,

Could you ACK that patch, please?

>  but I'm working on this one now..

That's good to hear.

>  So I don't want it deleted.

This is not something I get to decide. Nevertheless, given that this
file shouldn't have been merged to begin with, I'd appreciate it if some
deadline could be agreed upon.

That being said, I'm not sure how having just this file in mainline
helps your development efforts. It seems it did receive some updates
for, well, treewide stuff. But it surely didn't get build coverage or
runtime testing. So would you lose much if it only remains in your
development tree?


Paul Bolle
