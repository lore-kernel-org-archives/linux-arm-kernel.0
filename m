From: konrad.wilk@oracle.com (Konrad Rzeszutek Wilk)
Date: Sat, 10 Jun 2017 22:37:26 -0400
Subject: [PATCH 08/44] xen-swiotlb: implement ->mapping_error
In-Reply-To: <20170608132609.32662-9-hch@lst.de>
References: <20170608132609.32662-1-hch@lst.de>
 <20170608132609.32662-9-hch@lst.de>
Message-ID: <20170611023726.GF30966@char.us.oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 08, 2017 at 03:25:33PM +0200, Christoph Hellwig wrote:
> DMA_ERROR_CODE is going to go away, so don't rely on it.

Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
