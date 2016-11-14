From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 14 Nov 2016 07:12:28 -0700
Subject: [PATCH v4 1/2] iommu/dma: Implement dma_{map,unmap}_resource()
In-Reply-To: <d1cbd5ce714ce3c978aa8bfcb31def87d7919198.1479125555.git.robin.murphy@arm.com>
References: <d1cbd5ce714ce3c978aa8bfcb31def87d7919198.1479125555.git.robin.murphy@arm.com>
Message-ID: <20161114141228.eegibrpap2fyjr5v@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 14, 2016 at 12:16:26PM +0000, Robin Murphy wrote:
> With the new dma_{map,unmap}_resource() functions added to the DMA API
> for the benefit of cases like slave DMA, add suitable implementations to
> the arsenal of our generic layer. Since cache maintenance should not be
> a concern, these can both be standalone callback implementations without
> the need for arch code wrappers.
> 
> CC: Joerg Roedel <joro@8bytes.org>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

FWIW:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
