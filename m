From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 08 Jun 2010 11:42:28 +0100
Subject: [PATCH] ARM: Add PI/robust mutexes support for SMP kernels
In-Reply-To: <20100608102630.GA22993@n2100.arm.linux.org.uk>
References: <20100608102630.GA22993@n2100.arm.linux.org.uk>
Message-ID: <1275993748.2127.21.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-06-08 at 11:26 +0100, Russell King - ARM Linux wrote:
> On Tue, Jun 08, 2010 at 11:04:15AM +0100, Catalin Marinas wrote:
> > On Mon, 2010-06-07 at 22:52 +0100, Russell King - ARM Linux wrote:
> > > On Mon, Jun 07, 2010 at 10:05:57PM +0100, Catalin Marinas wrote:
> > > > But as I said, we already have patches to change the kernel R/W
> > > > permission for RO user pages.
> > >
> > > ... but they introduce their own problem.
> >
> > And these problem are ...
> 
> As pointed out in May.

Your first point was FIQ handlers and I updated the patch.

Your second point was I/D cache coherency and I also replied saying that
it doesn't matter on non-aliasing VIPT caches. There was no further
reply from you.

-- 
Catalin
