From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 2 Apr 2011 10:03:30 +0100
Subject: RFC, GIC based smp_cross_call cleanup suggestion
In-Reply-To: <BANLkTimY+mRXqT7NwUQ86SxnfKw0HX-pTQ@mail.gmail.com>
References: <10921831-0170-4106-bb3a-a52515a32c3e@VA3EHSMHS002.ehs.local>
	<BANLkTimY+mRXqT7NwUQ86SxnfKw0HX-pTQ@mail.gmail.com>
Message-ID: <20110402090330.GG8482@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 01, 2011 at 04:55:02PM -0600, Grant Likely wrote:
> On Fri, Apr 1, 2011 at 4:26 PM, John Linn <John.Linn@xilinx.com> wrote:
> > I?m getting ready to submit a patch to add SMP to Xilinx code. I notice that
> > smp_cross_call for all GIC based platforms is duplicated across each
> > platform in smp.h.
> >
> >
> >
> > I thought I?d try to jump in to help with some cleanup, although I realize
> > it?s minimal, I have to start somewhere.
> >
> >
> >
> > What about moving the smp_cross_call for GIC based designs into gic.h?
> 
> Go for it.  It's an obvious cleanup.

BTW, where's John's original email?  It hasn't come through the mailing
list from what I can see.
