From: hch@lst.de (Christoph Hellwig)
Date: Wed, 25 Jul 2018 13:29:44 +0200
Subject: [PATCH v2 3/7] ACPI/IORT: Set bus DMA mask as appropriate
In-Reply-To: <07cbf8f77fac552dca9b4c85a9d3bd8ed5a4cd29.1532382222.git.robin.murphy@arm.com>
References: <cover.1532382222.git.robin.murphy@arm.com>
 <07cbf8f77fac552dca9b4c85a9d3bd8ed5a4cd29.1532382222.git.robin.murphy@arm.com>
Message-ID: <20180725112944.GB24736@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 23, 2018 at 11:16:08PM +0100, Robin Murphy wrote:
> When an explicit DMA limit is described by firmware, we need to remember
> it regardless of how drivers might subsequently update their devices'
> masks. The new bus_dma_mask field does that.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
