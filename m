From: joro@8bytes.org ('Joerg Roedel')
Date: Wed, 14 Aug 2013 12:56:16 +0200
Subject: [PATCH v9 04/16] iommu/exynos: allocate lv2 page table from own
 slab
In-Reply-To: <2101296.S6JDU5igl3@flatron>
References: <002801ce941a$fb6369e0$f22a3da0$@samsung.com>
 <2544843.sndV7usHTj@amdc1227>
 <20130809145849.790a9800f4f9893b30e54a1c@samsung.com>
 <2101296.S6JDU5igl3@flatron>
Message-ID: <20130814105615.GG4491@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 09, 2013 at 09:55:30AM +0200, Tomasz Figa wrote:
> Oh, this is a valid point, but it was more a nitpick about the coding 
> style. Single path error handling (with goto) is widely used in the kernel 
> in cases when more than one thing has to be undone and so I suggested this 
> method of error handling here as well.

I agree with that review from Tomasz, the error-handling should look
similar to all the other places in the kernel and use goto.


	Joerg
