From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 7 May 2010 19:26:37 +0100
Subject: MSM PMU Support in Commit ee3c454b
In-Reply-To: <1273256647.3542.45.camel@c-dwalke-linux.qualcomm.com>
References: <000101caee07$104acdc0$30e06940$@deacon@arm.com>
	<20100507181543.GC7887@n2100.arm.linux.org.uk>
	<1273256647.3542.45.camel@c-dwalke-linux.qualcomm.com>
Message-ID: <20100507182637.GE7887@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 07, 2010 at 11:24:07AM -0700, Daniel Walker wrote:
> On Fri, 2010-05-07 at 19:15 +0100, Russell King - ARM Linux wrote:
> > Maybe I'll just keep the devel-stable branch entirely separate until
> > the devel stuff has been merged, and then MSM can be sorted at some
> > point later.  This unfortunately means that devel-stable drops out of
> > linux-next.  It also means that linux-next is at risk of missing the
> > merge window... again.
> 
> Would it matter if you just did a revert on the MSM pmu patch ?

No - and it might be better if you did it.  I could do it on my
devel-stable branch but then that'll cause you problems if you
apply a patch from Will for this (but I think you'll have problems
with that whichever way.)
