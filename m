From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 17 Aug 2018 00:24:15 -0700
Subject: [PATCH 0/3] iommu: Avoid DMA ops domain refcount contention
In-Reply-To: <cover.1534250425.git.robin.murphy@arm.com>
References: <cover.1534250425.git.robin.murphy@arm.com>
Message-ID: <20180817072415.GA22241@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I plan to make the arm iommu dma ops generic and move them to
drivers/iommu for the 4.20 merge window.  Because of that it would
be great to create a stable branch or even pull this in through
the dma-mapping tree entirely.
