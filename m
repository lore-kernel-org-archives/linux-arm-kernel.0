From: davem@davemloft.net (David Miller)
Date: Thu, 08 Jun 2017 10:22:35 -0400 (EDT)
Subject: [PATCH 27/44] sparc: remove leon_dma_ops
In-Reply-To: <20170608132609.32662-28-hch@lst.de>
References: <20170608132609.32662-1-hch@lst.de>
 <20170608132609.32662-28-hch@lst.de>
Message-ID: <20170608.102235.262414851920420864.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Christoph Hellwig <hch@lst.de>
Date: Thu,  8 Jun 2017 15:25:52 +0200

> We can just use pci32_dma_ops.
> 
> Btw, given that leon is 32-bit and appears to be PCI based, do even need
> the special case for it in get_arch_dma_ops at all?

I would need to defer to the LEON developers on that, but they haven't
been very actively lately so whether you'll get a response or not is
hard to predict.

> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: David S. Miller <davem@davemloft.net>
