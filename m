From: will.deacon@arm.com (Will Deacon)
Date: Fri, 29 Nov 2013 11:44:53 +0000
Subject: [RFC PATCH] Documentation: devicetree: add description for
 generic bus properties
In-Reply-To: <20131128212528.GA6144@kroah.com>
References: <20131127172806.GC2291@e103592.cambridge.arm.com>
 <20131127230650.GA6162@kroah.com>
 <20131128102845.GB21354@mudshark.cambridge.arm.com>
 <20131128173339.GB4634@e103592.cambridge.arm.com>
 <20131128191331.GB2385@kroah.com>
 <20131128193917.GC4634@e103592.cambridge.arm.com>
 <20131128212528.GA6144@kroah.com>
Message-ID: <20131129114453.GC21336@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 28, 2013 at 09:25:28PM +0000, Greg KH wrote:
> On Thu, Nov 28, 2013 at 07:39:17PM +0000, Dave Martin wrote:
> > On Thu, Nov 28, 2013 at 11:13:31AM -0800, Greg KH wrote:
> > > Yes it is, you all are the ones tasked with implementing the crazy crap
> > > the hardware people have created, best of luck with that :)
> > 
> > Agreed.  The first assumption should be that we can fit in with the
> > existing device model -- we should only reconsider if we find that
> > to be impossible.
> 
> Let me know if you think it is somehow impossible, but you all should
> really push back on the insane hardware designers that are forcing you
> all to do this work.  I find it "interesting" how this all becomes your
> workload for their crazy ideas.

Oh, I don't think we're claiming anything is impossible here :) It's more
that we will probably want to make some changes to the device model to allow,
for example, a device to be associated with multiple buses of potentially
different types.

Step one is to get the DT binding sorted, then we can try and get Linux to
make use of it. This goes hand-in-hand with the IOMMU discussion going on
here:

  http://lists.infradead.org/pipermail/linux-arm-kernel/2013-November/210401.html

which is one of the issues that is hitting us right now.

Cheers,

Will
