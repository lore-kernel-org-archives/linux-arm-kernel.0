From: will.deacon@arm.com (Will Deacon)
Date: Mon, 12 Jan 2015 13:00:21 +0000
Subject: [PATCH RESEND] dma-mapping: tidy up dma_parms default handling
In-Reply-To: <2031542.TLqIP3YVGc@wuerfel>
References: <ffdc5455d698d2525f2d126d0adabf9418fd76b1.1418990609.git.robin.murphy@arm.com>
 <2031542.TLqIP3YVGc@wuerfel>
Message-ID: <20150112130021.GC13360@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 09, 2015 at 07:45:49PM +0000, Arnd Bergmann wrote:
> On Friday 09 January 2015 16:56:03 Robin Murphy wrote:
> > 
> > This one's a bit tricky to find a home for - I think technically it's 
> > probably an IOMMU patch, but then the long-underlying problem doesn't
> > seem to have blown up anything until arm64, and my motivation is to
> > make bits of Juno work, which seems to nudge it towards arm64/arm-soc
> > territory. Could anyone suggest which tree is most appropriate?
> 
> I have a set of patches touching various dma-mapping.h related bits
> across architectures and in ARM in particular. Your patch fits into
> that series, and I guess we could either have it in my asm-generic
> tree or in Andrew Morton's mm tree. Possibly also arm-soc for practical
> reasons, although it really doesn't belong in there.

I also have a couple of fixes for issues found by Laurent for tearing
down the IOMMU dma ops, so you could include those too.

I'll send them out this afternoon.

Will
