From: agruen@suse.de (Andreas Gruenbacher)
Date: Sun, 5 Sep 2010 00:26:08 +0200
Subject: [bug-patch] Re: [BUG?] rename patch accepted with --dry-run,
	rejected without (Re: [PATCH V3] arm & sh: factorised duplicated
	clkdev.c)
In-Reply-To: <20100904220152.GB20444@n2100.arm.linux.org.uk>
References: <1283431716-21540-1-git-send-email-plagnioj@jcrosoft.com>
	<201009042346.11787.agruen@suse.de>
	<20100904220152.GB20444@n2100.arm.linux.org.uk>
Message-ID: <201009050026.08235.agruen@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 05 September 2010 00:01:52 Russell King - ARM Linux wrote:
> On Sat, Sep 04, 2010 at 11:46:11PM +0200, Andreas Gruenbacher wrote:
> > On Saturday 04 September 2010 23:45:27 Russell King - ARM Linux wrote:
> > > It also makes them incompatible with GNU patch, whether or not GNU patch
> > > understands the GIT headers.
> > 
> > Aha?  Then why do you think GNU patch tries to understand the GIt patch 
> > headers?  So that it can be incompatible with GIT?
> 
> Read what you said last time around.  "In this case, the patch itself is
> broken."

I was corrected on that by Jonathan Nieder's mail which describes a detail of 
the GIT patch format that I didn't know about.  So it's a bug in the way GNU 
patch handles the git patch format and not an error in the patch.  Not nice 
and probably not easy to fix, but not fundamentally unfixable.

Andreas
