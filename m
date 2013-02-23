From: ananaza@iki.fi (Antti P Miettinen)
Date: Sat, 23 Feb 2013 22:41:17 +0200 (EET)
Subject: L1 & L2 cache flush sequence on CortexA5 MPcore w.r.t low
 power modes
In-Reply-To: <20130222093927.GA12140@e102568-lin.cambridge.arm.com>
References: <874nmowhm1.fsf@amiettinen-lnx.nvidia.com>
 <87liag67p7.fsf@amiettinen-lnx.nvidia.com>
 <20130222093927.GA12140@e102568-lin.cambridge.arm.com>
Message-ID: <20130223.224117.1863795394020246928.apm@brigitte.kvy.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> On Fri, Feb 22, 2013 at 09:04:04AM +0000, Antti P Miettinen wrote:
>> This did not get answered - are TLB fetches by sibling cores treated in
>> the same way as cache fetches? If core A has C bit cleared, is the cache
>> still available for TLB fetches by core B?
> 
> Yes, it is as long as the SMP bit is set in ACTLR.
> 
> Lorenzo

Thanks Lorenzo. Do you know if there are any known errata that would
invalidate any of the assumptions disussed in this thread?

--
Antti P Miettinen
http://www.iki.fi/~ananaza/
