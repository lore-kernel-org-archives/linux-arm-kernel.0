From: joro@8bytes.org (Joerg Roedel)
Date: Mon, 26 Nov 2012 12:20:58 +0100
Subject: [PATCH 0/9] dma_debug: add debug_dma_mapping_error support to
 architectures that support DMA_DEBUG_API
In-Reply-To: <50B34B0F.3080204@samsung.com>
References: <1353706142.5270.93.camel@lorien2> <50B34B0F.3080204@samsung.com>
Message-ID: <20121126112058.GF25742@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 26, 2012 at 11:57:19AM +0100, Marek Szyprowski wrote:
> I've took all the patches to the next-dma-debug branch in my tree, I sorry
> that You have to wait so long for it. My branch is based on Joerg's
> dma-debug branch and I've included it for testing in linux-next branch.
> 
> Joerg: would You mind if I handle pushing the whole branch to v3.8
> via my kernel tree? Those changes should be kept close together to
> avoid build breaks for bisecting.

I'll apply the patches to my tree soon enough. But before that I'll wait
a little bit longer to give the arch maintainers the chance to add the
missing Acked-bys.


	Joerg
