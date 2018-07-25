From: joro@8bytes.org (Joerg Roedel)
Date: Wed, 25 Jul 2018 14:11:06 +0200
Subject: [PATCH v2 0/7] Stop losing firmware-set DMA masks
In-Reply-To: <20180725113122.GD24736@lst.de>
References: <cover.1532382222.git.robin.murphy@arm.com>
 <20180725113122.GD24736@lst.de>
Message-ID: <20180725121106.GK18541@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 25, 2018 at 01:31:22PM +0200, Christoph Hellwig wrote:
> Hi Robin,
> 
> this series looks fine to me.  Do you want me to pull this into the
> dma-mapping tree?  I'd like to see a few more ACKs from the ACPI/OF/
> IOMMU maintainers though.

For the IOMMU parts:

	Acked-by: Joerg Roedel <jroedel@suse.de>
