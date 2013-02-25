From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 25 Feb 2013 13:36:02 +0000
Subject: L1 & L2 cache flush sequence on CortexA5 MPcore w.r.t low power
 modes
In-Reply-To: <20130223.224117.1863795394020246928.apm@brigitte.kvy.fi>
References: <874nmowhm1.fsf@amiettinen-lnx.nvidia.com>
 <87liag67p7.fsf@amiettinen-lnx.nvidia.com>
 <20130222093927.GA12140@e102568-lin.cambridge.arm.com>
 <20130223.224117.1863795394020246928.apm@brigitte.kvy.fi>
Message-ID: <20130225133602.GB13045@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 23, 2013 at 08:41:17PM +0000, Antti P Miettinen wrote:
> From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > On Fri, Feb 22, 2013 at 09:04:04AM +0000, Antti P Miettinen wrote:
> >> This did not get answered - are TLB fetches by sibling cores treated in
> >> the same way as cache fetches? If core A has C bit cleared, is the cache
> >> still available for TLB fetches by core B?
> > 
> > Yes, it is as long as the SMP bit is set in ACTLR.
> > 
> > Lorenzo
> 
> Thanks Lorenzo. Do you know if there are any known errata that would
> invalidate any of the assumptions disussed in this thread?

If you can provide me with a bit of context I am happy to help you chase
ths issue(s), since it looks like you are facing some.

Thanks,
Lorenzo
