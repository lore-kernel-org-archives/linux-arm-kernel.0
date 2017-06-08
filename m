From: davem@davemloft.net (David Miller)
Date: Thu, 08 Jun 2017 10:24:29 -0400 (EDT)
Subject: [PATCH 20/44] sparc: implement ->mapping_error
In-Reply-To: <20170608132609.32662-21-hch@lst.de>
References: <20170608132609.32662-1-hch@lst.de>
 <20170608132609.32662-21-hch@lst.de>
Message-ID: <20170608.102429.1779556729256854546.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Christoph Hellwig <hch@lst.de>
Date: Thu,  8 Jun 2017 15:25:45 +0200

> DMA_ERROR_CODE is going to go away, so don't rely on it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: David S. Miller <davem@davemloft.net>
