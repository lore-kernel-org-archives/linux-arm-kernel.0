From: will.deacon@arm.com (Will Deacon)
Date: Fri, 17 Aug 2018 10:03:23 +0100
Subject: [PATCH 0/3] iommu: Avoid DMA ops domain refcount contention
In-Reply-To: <20180817072415.GA22241@infradead.org>
References: <cover.1534250425.git.robin.murphy@arm.com>
 <20180817072415.GA22241@infradead.org>
Message-ID: <20180817090322.GA8540@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 17, 2018 at 12:24:15AM -0700, Christoph Hellwig wrote:
> I plan to make the arm iommu dma ops generic and move them to
> drivers/iommu for the 4.20 merge window.  Because of that it would
> be great to create a stable branch or even pull this in through
> the dma-mapping tree entirely.

In which case, for the arm64 bits:

Acked-by: Will Deacon <will.deacon@arm.com>

Will
