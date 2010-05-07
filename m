From: dwalker@codeaurora.org (Daniel Walker)
Date: Fri, 07 May 2010 12:20:28 -0700
Subject: MSM PMU Support in Commit ee3c454b
In-Reply-To: <20100507190148.GF7887@n2100.arm.linux.org.uk>
References: <000101caee07$104acdc0$30e06940$@deacon@arm.com>
	<20100507181543.GC7887@n2100.arm.linux.org.uk>
	<1273256647.3542.45.camel@c-dwalke-linux.qualcomm.com>
	<20100507182637.GE7887@n2100.arm.linux.org.uk>
	<1273258767.3542.80.camel@c-dwalke-linux.qualcomm.com>
	<20100507190148.GF7887@n2100.arm.linux.org.uk>
Message-ID: <1273260028.3542.96.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-05-07 at 20:01 +0100, Russell King - ARM Linux wrote:
> On Fri, May 07, 2010 at 11:59:27AM -0700, Daniel Walker wrote:
> > On Fri, 2010-05-07 at 19:26 +0100, Russell King - ARM Linux wrote:
> > > On Fri, May 07, 2010 at 11:24:07AM -0700, Daniel Walker wrote:
> > > > On Fri, 2010-05-07 at 19:15 +0100, Russell King - ARM Linux wrote:
> > > > > Maybe I'll just keep the devel-stable branch entirely separate until
> > > > > the devel stuff has been merged, and then MSM can be sorted at some
> > > > > point later.  This unfortunately means that devel-stable drops out of
> > > > > linux-next.  It also means that linux-next is at risk of missing the
> > > > > merge window... again.
> > > > 
> > > > Would it matter if you just did a revert on the MSM pmu patch ?
> > > 
> > > No - and it might be better if you did it.  I could do it on my
> > > devel-stable branch but then that'll cause you problems if you
> > > apply a patch from Will for this (but I think you'll have problems
> > > with that whichever way.)
> > 
> > I'll add a revert on my for-russell branch, then you can pull that. Is
> > that what your thinking ?
> 
> Yup.

Ok, I updated my for-russell branch with a revert , let me know if
that's satisfactory ..

Daniel
