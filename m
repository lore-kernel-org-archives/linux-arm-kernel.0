From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 29 Oct 2012 14:48:55 +0000
Subject: [PATCH v4 0/5] zynq subarch cleanups
In-Reply-To: <20121029133609.GE5190@beefymiracle.amer.corp.natinst.com>
References: <cover.1351466765.git.josh.cartwright@ni.com>
 <5c2911d7-f753-4d9f-b8d8-3bf011d58e52@TX2EHSMHS014.ehs.local>
 <20121029133609.GE5190@beefymiracle.amer.corp.natinst.com>
Message-ID: <92733d32-890b-42ab-b693-3240e9613935@TX2EHSMHS013.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Josh Cartwright [mailto:josh.cartwright at ni.com]
> Sent: Monday, October 29, 2012 2:36 PM
> To: Michal Simek
> Cc: arm at kernel.org; linux-kernel at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; John Linn; Nick Bowler; Arnd Bergmann
> Subject: Re: [PATCH v4 0/5] zynq subarch cleanups
> 
> On Mon, Oct 29, 2012 at 07:24:16AM +0000, Michal Simek wrote:
> > Hi Josh,
> >
> > > Michal-
> > >
> > > Here is a v5 of the zynq cleanup patchset that addresses your
> > > feedback.  I've intentionally left patches 4 and 5 in the set until
> > > we figure out the appropriate way to get them in tree (feel free to
> > > just apply 1-3)
> >
> > I am ok to pick just several patches from your patchset. But this is
> > no definitely good working style. Not expert for submission process
> > but I think that if there is one broken patch maintainer shouldn't
> > apply it.  Can someone else check this?
> 
> It turns out that with the change to patch 5 to map the uart to a known working
> address (instead of VMALLOC_END - 0x1000), patch 4 isn't needed, and as such
> can be dropped.  (I didn't realize this until this morning until I had saw you had
> applied 1-3,5 to your tree, but not 4).
> 
> So, for what it's worth, you've applied all of the relevant patches for this
> patchset.

Ok. Great.

Thanks,
MIchal
