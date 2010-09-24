From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 23 Sep 2010 22:33:22 -0600
Subject: [PATCH] ARM: abstract atags parsing
In-Reply-To: <4C9BE3FE.1070704@fluff.org>
References: <alpine.LFD.2.00.1009231713570.13233@xanadu.home>
	<20100923213113.GC26295@n2100.arm.linux.org.uk>
	<AANLkTikwT-w_6Y+yzZ014g6tijUTUzZUAa7g=eE8F+nt@mail.gmail.com>
	<4C9BE3FE.1070704@fluff.org>
Message-ID: <20100924043322.GA19260@angua.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 24, 2010 at 12:34:22AM +0100, Ben Dooks wrote:
> On 23/09/10 22:53, Grant Likely wrote:
> > On Thu, Sep 23, 2010 at 3:31 PM, Russell King - ARM Linux
> > <linux@arm.linux.org.uk> wrote:
> >> On Thu, Sep 23, 2010 at 05:18:02PM -0400, Nicolas Pitre wrote:
> >>> This code movement will make it cleaner and easier to introduce support
> >>> for device tree which is basically an alternative to atags. No functional
> >>> changes are introduced by this patch.
> >>
> >> I don't see any point to this churn.
> > 
> > I can carry it in test-devicetree branch until you become okay with it.
> > 
> >> DT has yet to be shown to be useful on anything but the ARM evaluation
> >> boards, and that's one of the pre-conditions to it becoming acceptable
> >> (which has been pending for a few years now.)
> > 
> > I started working on ARM DT support in November/December 2009.  Not
> > even a year yet.
>
> I don't believe you're the only one to be or have been working on it,
> but I've no direct references to other work and can't be bothered to
> go and find any.

There was an attempt or two before I started working on it.  Janboe Ye
posted one version on May 27, 09, but it wasn't viable.  Basically
took the approach of duplicating the powerpc code instead of moving it
to a common location and generalizing it.

Jeremy Kerr started hacking on it shortly after I began, and quite a few
other engineers have started working on it since.  The MIPS folks also
have patches pending to add support, and I've also got x86 patches
that may very well get merged in the next window.

g.
