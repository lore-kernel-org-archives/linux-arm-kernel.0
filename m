From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 2 May 2018 05:46:17 -0700
Subject: centralize SWIOTLB config symbol and misc other cleanups V3
In-Reply-To: <20180425051539.1989-1-hch@lst.de>
References: <20180425051539.1989-1-hch@lst.de>
Message-ID: <20180502124617.GA22001@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Any more comments?  Especially from the x86, mips and powerpc arch
maintainers?  I'd like to merge this in a few days as various other
patches depend on it.

On Wed, Apr 25, 2018 at 07:15:26AM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> this seris aims for a single defintion of the Kconfig symbol.  To get
> there various cleanups, mostly about config symbols are included as well.
> 
> Changes since V2:
>  - swiotlb doesn't need the dma_length field by itself, so don't select it
>  - don't offer a user visible SWIOTLB choice
> 
> Chages since V1:
>  - fixed a incorrect Reviewed-by that should be a Signed-off-by.
> _______________________________________________
> iommu mailing list
> iommu at lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
---end quoted text---
