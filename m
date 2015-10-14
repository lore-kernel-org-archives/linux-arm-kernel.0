From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 14 Oct 2015 14:35:38 +0100
Subject: [PATCH v6 2/3] arm64: Add IOMMU dma_ops
In-Reply-To: <80cb035144a2648a5d94eb1fec3336f17ad249f1.1443718557.git.robin.murphy@arm.com>
References: <cover.1443718557.git.robin.murphy@arm.com>
 <80cb035144a2648a5d94eb1fec3336f17ad249f1.1443718557.git.robin.murphy@arm.com>
Message-ID: <20151014133538.GG4239@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 01, 2015 at 08:13:59PM +0100, Robin Murphy wrote:
> Taking some inspiration from the arch/arm code, implement the
> arch-specific side of the DMA mapping ops using the new IOMMU-DMA layer.
> 
> Since there is still work to do elsewhere to make DMA configuration happen
> in a more appropriate order and properly support platform devices in the
> IOMMU core, the device setup code unfortunately starts out carrying some
> workarounds to ensure it works correctly in the current state of things.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Sorry, I reviewed this patch before but forgot to ack it, so here it is:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

(and I'm fined for the arm64 patches here to go in via the iommu tree)

I assume part of this patch will disappear at some point when the device
probing order is sorted.

-- 
Catalin
