From: thommyj@gmail.com (Thommy Jakobsson)
Date: Tue, 10 Sep 2013 13:28:50 +0200 (CEST)
Subject: kmalloc memory slower than malloc
In-Reply-To: <9848F2DB572E5649BA045B288BE08FBE016A9D4A@039-SN2MPN1-023.039d.mgd.msft.net>
References: <alpine.DEB.2.02.1309060811400.1299@kelly.ryd.net>
 <1378458778.4208.30.camel@weser.hi.pengutronix.de>
 <alpine.DEB.2.02.1309101124450.1305@kelly.ryd.net>
 <1378807816.4200.6.camel@weser.hi.pengutronix.de>
 <9848F2DB572E5649BA045B288BE08FBE016A9D4A@039-SN2MPN1-023.039d.mgd.msft.net>
Message-ID: <alpine.DEB.2.02.1309101327340.1305@kelly.ryd.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tue, 10 Sep 2013, Duan Fugang-B38611 wrote:

> About the diff:
> dma_alloc_coherent in kernel   4.256s (s=0)
> dma_alloc_coherent userspace   0.566s (s=0)
> 
> I think it call remap_pfn_range() with page attribute (vma->vm_page_prot) transferred from mmap() maybe cacheable.
> So the performance is the same as malloc/kmalloc in userspace.
> 
Thats probably true, or at least that is how I explained it to myself in 
my head =) 

Thanks,
Thommy
