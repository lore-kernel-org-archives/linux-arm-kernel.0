From: hch@lst.de (Christoph Hellwig)
Date: Wed, 25 Jul 2018 13:30:00 +0200
Subject: [PATCH v2 4/7] of/device: Set bus DMA mask as appropriate
In-Reply-To: <cc56f074b8da7e03a187b2363b1f2c2955d62c1c.1532382222.git.robin.murphy@arm.com>
References: <cover.1532382222.git.robin.murphy@arm.com>
 <cc56f074b8da7e03a187b2363b1f2c2955d62c1c.1532382222.git.robin.murphy@arm.com>
Message-ID: <20180725113000.GC24736@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 23, 2018 at 11:16:09PM +0100, Robin Murphy wrote:
> When an explicit DMA limit is described by firmware, we need to remember
> it regardless of how drivers might subsequently update their devices'
> masks. The new bus_dma_mask field does that.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
