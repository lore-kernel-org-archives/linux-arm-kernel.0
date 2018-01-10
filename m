From: hch@lst.de (Christoph Hellwig)
Date: Wed, 10 Jan 2018 16:22:15 +0100
Subject: [PATCH 11/33] dma-mapping: move swiotlb arch helpers to a new
 header
In-Reply-To: <b2bd6f4b-a932-5251-517b-83bbccfe7c53@arm.com>
References: <20180110080027.13879-1-hch@lst.de>
 <20180110080027.13879-12-hch@lst.de>
 <b2bd6f4b-a932-5251-517b-83bbccfe7c53@arm.com>
Message-ID: <20180110152215.GA17790@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 10, 2018 at 09:31:45AM +0000, Vladimir Murzin wrote:
> I know it is copy&paste, but it seems it has off by one error and it should be
> 
> return addr + size - 1 <= *dev->dma_mask;

I've added a new patch to fix the mips dma_capable() definition,
thanks.
