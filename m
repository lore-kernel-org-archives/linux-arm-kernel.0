From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 16 Nov 2009 16:30:28 +0000
Subject: cache aliasing in dup_mmap
In-Reply-To: <e06498070911130649k2051e4cfh2066cf0b9fdabbaf@mail.gmail.com>
References: <e06498070903062020s22222594h7be318fb9f3fdaee@mail.gmail.com>
	<ca992f110903080105ye955070t260e6a4334186986@mail.gmail.com>
	<20090308121029.GA21277@n2100.arm.linux.org.uk>
	<20090308143607.GA27349@n2100.arm.linux.org.uk>
	<e06498070909290925q55777041q6f3ecfaf9847babb@mail.gmail.com>
	<e06498070909290930w7745e1e3x2e224ad75ff62dbd@mail.gmail.com>
	<20090929191108.GA13568@n2100.arm.linux.org.uk>
	<20091005144623.GA20633@n2100.arm.linux.org.uk>
	<20091105144830.GC21681@n2100.arm.linux.org.uk>
	<e06498070911130649k2051e4cfh2066cf0b9fdabbaf@mail.gmail.com>
Message-ID: <20091116163028.GA3568@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 13, 2009 at 09:49:42AM -0500, Steven Walter wrote:
> On Thu, Nov 5, 2009 at 9:48 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> >> I've not heard anything further. ?I've thrown the patches into the git
> >> tree under a separate branch now (top two):
> >>
> >> http://ftp.arm.linux.org.uk/git/gitweb.cgi?p=linux-2.6-arm.git;a=shortlog;h=refs/heads/cup
> >>
> >> I do feel that more work needs to be done to the 2nd patch though.
> >
> > Okay, enough. ?This issue is NOT going to get fixed unless you (or
> > someone else who can reproduce your problem) responds.
> >
> > No response, no fix. ?Simple, really. ?I give you two weeks to respond
> > on this issue so it can be progressed before the above branch is trashed.
> >
> 
> I apologize for the late reply.  I have a build with your patches
> running in a reboot loop (the easiest way for us to reproduce the
> crash).  I should have a good indication of whether the patches fix
> the issue by Monday.

Any results?
