From: joro@8bytes.org (Joerg Roedel)
Date: Tue, 25 Sep 2018 10:24:49 +0200
Subject: [PATCH v2 0/3] iommu: Avoid DMA ops domain refcount contention
In-Reply-To: <cover.1536764440.git.robin.murphy@arm.com>
References: <cover.1536764440.git.robin.murphy@arm.com>
Message-ID: <20180925082449.2pug6jglyl2dg5vn@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 12, 2018 at 04:24:11PM +0100, Robin Murphy wrote:
> Robin Murphy (3):
>   iommu: Add fast hook for getting DMA domains
>   iommu/dma: Use fast DMA domain lookup
>   arm64/dma-mapping: Mildly optimise non-coherent IOMMU ops

Applied, thanks Robin.
