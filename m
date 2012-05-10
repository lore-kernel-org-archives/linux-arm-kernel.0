From: will.deacon@arm.com (Will Deacon)
Date: Thu, 10 May 2012 09:38:33 +0100
Subject: Bug in v7_coherent_kern_range() ?
In-Reply-To: <4FAB2D28.4050800@freescale.com>
References: <4F77C9A6.6080601@freescale.com>
 <20120402111240.GG19011@mudshark.cambridge.arm.com>
 <4F7E646D.6000302@freescale.com>
 <20120410092214.GA2620@mudshark.cambridge.arm.com>
 <4F840BDC.5060307@freescale.com> <4F854992.9080601@freescale.com>
 <20120411102437.GE16643@mudshark.cambridge.arm.com>
 <4FAB2D28.4050800@freescale.com>
Message-ID: <20120510083833.GA27276@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 10, 2012 at 03:51:20AM +0100, Huang Shijie wrote:
> Hi Will:
> > If you still have this problem with a newer kernel, we can try using the
> > fallback SMP futex implementation and see if that works.
> >
> After we update our application(gstreamer), the futex issue gone.
> So this is not a kernel bug, but an application bug.

That's good to hear, thanks for reporting back.

Will
