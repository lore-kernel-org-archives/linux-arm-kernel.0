From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 5 Nov 2009 14:48:30 +0000
Subject: cache aliasing in dup_mmap
In-Reply-To: <20091005144623.GA20633@n2100.arm.linux.org.uk>
References: <e06498070903061426o5875ad13hc6328aa0d3f08ed7@mail.gmail.com>
	<20090306225525.GB3212@n2100.arm.linux.org.uk>
	<e06498070903062020s22222594h7be318fb9f3fdaee@mail.gmail.com>
	<ca992f110903080105ye955070t260e6a4334186986@mail.gmail.com>
	<20090308121029.GA21277@n2100.arm.linux.org.uk>
	<20090308143607.GA27349@n2100.arm.linux.org.uk>
	<e06498070909290925q55777041q6f3ecfaf9847babb@mail.gmail.com>
	<e06498070909290930w7745e1e3x2e224ad75ff62dbd@mail.gmail.com>
	<20090929191108.GA13568@n2100.arm.linux.org.uk>
	<20091005144623.GA20633@n2100.arm.linux.org.uk>
Message-ID: <20091105144830.GC21681@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 05, 2009 at 03:46:23PM +0100, Russell King - ARM Linux wrote:
> On Tue, Sep 29, 2009 at 08:11:08PM +0100, Russell King - ARM Linux wrote:
> > On Tue, Sep 29, 2009 at 12:30:27PM -0400, Steven Walter wrote:
> > > On Sun, Mar 8, 2009 at 10:36 AM, Russell King - ARM Linux
> > > <linux@arm.linux.org.uk> wrote:
> > > > On Sun, Mar 08, 2009 at 12:10:29PM +0000, Russell King - ARM Linux wrote:
> > > >> I don't think moving flush_cache_mm solves anything - the problem remains,
> > > >> but with a different timing.
> > > >
> > > > On the other hand, this should solve the problem. ?I'm not 100% happy
> > > > with this because we end up using the cache flush ops on the same memory
> > > > several times.
> > > 
> > > Russell
> > > 
> > > It appears that this patch is neither in Linus' tree nor the ARM
> > > master branch. ?Was a different fix committed to address the original
> > > memory corruption issue?
> > 
> > >From what I can see, there was no positive response to the actual patch
> > (and no testing of the actual patch), so it doesn't get merged.
> > 
> > Changes don't get merged until they themselves have been tested.
> 
> I've not heard anything further.  I've thrown the patches into the git
> tree under a separate branch now (top two):
> 
> http://ftp.arm.linux.org.uk/git/gitweb.cgi?p=linux-2.6-arm.git;a=shortlog;h=refs/heads/cup
> 
> I do feel that more work needs to be done to the 2nd patch though.

Okay, enough.  This issue is NOT going to get fixed unless you (or
someone else who can reproduce your problem) responds.

No response, no fix.  Simple, really.  I give you two weeks to respond
on this issue so it can be progressed before the above branch is trashed.
