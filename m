From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 24 Feb 2012 14:31:01 +0000
Subject: [PATCHv6 7/7] ARM: dma-mapping: add support for IOMMU mapper
In-Reply-To: <013301ccf2f6$bc4ad840$34e088c0$%szyprowski@samsung.com>
References: <1328900324-20946-1-git-send-email-m.szyprowski@samsung.com>
 <201202241249.44731.arnd@arndb.de>
 <013301ccf2f6$bc4ad840$34e088c0$%szyprowski@samsung.com>
Message-ID: <201202241431.02170.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 24 February 2012, Marek Szyprowski wrote:
> I want to use some kind of chained arrays, each of at most of PAGE_SIZE. This code 
> doesn't really need to keep these page pointers in contiguous virtual memory area, so
> it will not be a problem here.
> 
Sounds like sg_alloc_table(), could you reuse that instead of rolling your own?

	Arnd
