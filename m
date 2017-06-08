From: davem@davemloft.net (David Miller)
Date: Thu, 08 Jun 2017 10:21:55 -0400 (EDT)
Subject: [PATCH 02/44] ibmveth: properly unwind on init errors
In-Reply-To: <20170608132609.32662-3-hch@lst.de>
References: <20170608132609.32662-1-hch@lst.de>
 <20170608132609.32662-3-hch@lst.de>
Message-ID: <20170608.102155.1160530647510289129.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Christoph Hellwig <hch@lst.de>
Date: Thu,  8 Jun 2017 15:25:27 +0200

> That way the driver doesn't have to rely on DMA_ERROR_CODE, which
> is not a public API and going away.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: David S. Miller <davem@davemloft.net>
