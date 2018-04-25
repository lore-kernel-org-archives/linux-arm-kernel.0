From: davem@davemloft.net (David Miller)
Date: Wed, 25 Apr 2018 10:58:20 -0400 (EDT)
Subject: [PATCH 01/13] iommu-common: move to arch/sparc
In-Reply-To: <20180425051539.1989-2-hch@lst.de>
References: <20180425051539.1989-1-hch@lst.de>
 <20180425051539.1989-2-hch@lst.de>
Message-ID: <20180425.105820.1294383479112934639.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Christoph Hellwig <hch@lst.de>
Date: Wed, 25 Apr 2018 07:15:27 +0200

> This code is only used by sparc, and all new iommu drivers should use the
> drivers/iommu/ framework.  Also remove the unused exports.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>

Acked-by: David S. Miller <davem@davemloft.net>
