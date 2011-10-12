From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 12 Oct 2011 18:22:05 +0100
Subject: [PATCH 4/5 v4] Realview PCIX support - add main support module
	code
In-Reply-To: <000101cc872f$82425660$86c70320$@tuckley@arm.com>
References: <20111007142310.19554.17204.stgit@e102602-lin.cambridge.arm.com>
	<20111007142834.19554.69753.stgit@e102602-lin.cambridge.arm.com>
	<20111007231937.GC25689@n2100.arm.linux.org.uk>
	<000101cc872f$82425660$86c70320$@tuckley@arm.com>
Message-ID: <20111012172205.GB21648@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 10, 2011 at 10:32:20AM +0100, Colin Tuckley wrote:
> > -----Original Message-----
> > From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> > Subject: Re: [PATCH 4/5 v4] Realview PCIX support - add main support
> > module code
> 
> Russell said:
> 
> > I thought one of my previous review points on this was that it was
> > completely unsafe to match only on dev->device, rather than on both
> > dev->device and dev->vendor.  Device IDs are allocated by individual
> > vendors and are meaningless without also checking the vendor ID.
> 
> And
> 
> > And I thought we'd got to the point where we had a swizzle here.
> 
> The patch I sent to the list was indeed an old version. However the reason
> is that despite the testing we did and your suggested changes the swizzle
> based code still does not fully work. So I thought it best to post working
> code.
> 
> I'm still waiting for a response from you on the last round of test results
> I sent.

I don't have a response at the moment (and it's going to be a while
as I'm going to be using the next few days to catch up with quite a
backlog of email.)  I've also lost all the context from March - which
was an absolute necessity to ensure the survival of the ARM Linux in
the mainline kernel sources.
