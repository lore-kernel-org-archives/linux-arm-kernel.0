From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 6 Dec 2011 08:55:56 +0000
Subject: [PATCH 07/23] ARM: plat-omap: remove arch specific special
 handling for ioremap
In-Reply-To: <alpine.LFD.2.02.1112052246030.2357@xanadu.home>
References: <1321422521-1138-1-git-send-email-nico@fluxnic.net>
 <1321422521-1138-8-git-send-email-nico@fluxnic.net>
 <20111202202125.GZ31337@atomide.com>
 <alpine.LFD.2.02.1112021637200.2357@xanadu.home>
 <20111205235609.GI14542@n2100.arm.linux.org.uk>
 <20111206003659.GJ14542@n2100.arm.linux.org.uk>
 <alpine.LFD.2.02.1112052246030.2357@xanadu.home>
Message-ID: <20111206085556.GL14542@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 05, 2011 at 11:09:11PM -0500, Nicolas Pitre wrote:
> On Tue, 6 Dec 2011, Russell King - ARM Linux wrote:
> > On Mon, Dec 05, 2011 at 11:56:09PM +0000, Russell King - ARM Linux wrote:
> > > On Fri, Dec 02, 2011 at 04:39:31PM -0500, Nicolas Pitre wrote:
> > > > OK, thanks for testing.  Since Russell didn't commit this to his stable 
> > > > branch yet I simply folded in your fix and added your tested-by tag.
> > > 
> > > So I'm about to push what I had out in the devel-stable branch... what
> > > am I supposed to do with this?
> > 
> > Okay, yet again I find myself having to wait hours for a reply - which
> > I expect will be forthcoming sometime tomorrow afternoon my time.  If
> > I wait, it means a delay of another 24 hours before I push my tree out.
> > 
> > This is not acceptable.
> 
> You asked at 11:56:09PM +0000.
> I replied at 19:33:34 -0500.
> That's a delay of 37 minutes 25 seconds.
> I even received my reply back from the mailing list server at
> 19:39:37 -0500 so hopefully you must have received it within the hour.
> Granted, you merged my branch at 23:27:59 +0000 so I hadn't replied yet.

So?  I decided that I could _not_ wait for you to reply, because I'd
already waited three days for Tony to reply for his merge conflict, and
there's no way I was going to wait another 24 hours or so for someone
else to reply before pushing my tree out.

*Think* about what time it was over here, and think about what I was
about to do.

> However, the commit says:
> 
> Merge: 742eaa6a6e 0af362f844
> Author:     Russell King <rmk+kernel@arm.linux.org.uk>
> AuthorDate: Mon Dec 5 23:27:54 2011 +0000
> Commit:     Russell King <rmk+kernel@arm.linux.org.uk>
> CommitDate: Mon Dec 5 23:27:59 2011 +0000
> 
>     Merge branch 'vmalloc' of git://git.linaro.org/people/nico/linux into devel-stable
> 
> So the commit message is written as if you pulled my branch directly 
> instead of a local branch, however my repo was already updated by that 
> time.  In fact it was updated 2 days ago.  Strangely enough, you still 
> have a version prior to that last update.

I created this by using git merge of the original commit (0af362f844)
and editing the commit message.  As there's no way to preserve the
author date, that's unreliable.  And there's no way in hell I'd re-pull
it before you'd sent a new pull request.
